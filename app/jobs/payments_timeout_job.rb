# Some users think they've paid online but in reality they didn't finalised for
#  whatever reason the whole payment process. These payments will be left to expire
#  (time out) and the application will not be submitted to court. Sometimes they will
# contact the helpdesk telling they have a charge in their bank account. This charge
# is a pre-authorisation or hold charge and it is not the final payment and the
# application is not completed or submitted. The charge is dropped after a few days
# automatically by the bank.

class PaymentsTimeoutJob < ApplicationJob
  queue_as :default

  def self.run
    start = 75.minutes.ago
    ending = 60.minutes.ago
    C100Application.joins(:payment_intent)
      .where("payment_intents.state ->> 'finished' = 'false'")
      .where("payment_intents.created_at >= :start AND payment_intents.created_at < :ending", start:, ending:)
      .each do |c100_application|
        Rails.logger.info "Enqueuing payment timeout email #{c100_application.id}"
        NotifyMailer.payment_timeout(c100_application).deliver_later
      end
  end
end
