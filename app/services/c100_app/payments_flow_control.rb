module C100App
  class PaymentsFlowControl
    include Rails.application.routes.url_helpers

    attr_reader :c100_application

    def initialize(c100_application)
      @c100_application = c100_application
    end

    def payment_url
      if c100_application.online_payment?
        move_status_to :payment_in_progress
        OnlinePayments.create_payment(payment_intent).payment_url
      else
        confirmation_url
      end
    rescue StandardError => exception
      move_status_to :in_progress
      raise Errors::PaymentUnexpectedError, exception
    end

    # Returning users after paying (or failing/cancelling)
    def next_url
      if OnlinePayments.retrieve_payment(payment_intent).success?
        return confirmation_url
      end

      # For a while, until we are confident, let's log these failures
      log_failure_info

      # Revert to `in_progress` as we are certain at this point payment failed
      move_status_to :in_progress

      payment_error_errors_path
    rescue StandardError => exception
      raise Errors::PaymentUnexpectedError, exception
    end

    def confirmation_url
      move_status_to :completed

      if c100_application.online_submission?
        OnlineSubmissionQueue.new(c100_application).process
        steps_completion_confirmation_path
      else
        steps_completion_what_next_path
      end
    end

    private

    def payment_intent
      @_payment_intent ||= PaymentIntent.find_or_create_by!(
        c100_application: c100_application
      )
    end

    def move_status_to(status)
      case status
      when :in_progress
        c100_application.in_progress!
      when :payment_in_progress
        c100_application.payment_in_progress!
      when :completed
        c100_application.mark_as_completed!
      end
    end

    def log_failure_info
      Raven.capture_exception(
        Errors::PaymentError.new(payment_intent.state),
        level: 'info', tags: { payment_id: payment_intent.payment_id }
      )
    end
  end
end
