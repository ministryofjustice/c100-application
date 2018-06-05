class CumulativeData < ApplicationRecord
  # Data points processed daily through `/lib/tasks/daily_tasks.rake`
  #
  # To create new data points, add the field to the table and to this
  # collection, and then implement a class method of the same name.
  #
  DATA_POINTS ||= [
    :applications_created,
    :applications_eligible,
    :applications_completed,
    :applications_saved,
    :applications_online_submission,
    :applications_postal_submission,
  ].freeze

  def self.process!
    data = {}

    DATA_POINTS.each_with_object(data) do |column, hash|
      hash[column] = public_send(column)
    end

    create(data)
  end

  # The assumption here is we will be running a daily task to gather data
  # from the day before. If this assumption ever changes, adapt this method.
  def self.finder
    C100Application.where(
      created_at: [Date.yesterday.beginning_of_day..Date.yesterday.end_of_day]
    )
  end

  # Implement new data points below, as class methods
  #
  class << self
    def applications_created
      finder.count
    end

    # Any application that has completed the screener, no matter the status
    def applications_eligible
      finder.where(
        'navigation_stack && ?', '{/steps/screener/done, /entrypoint/v1}'
      ).count
    end

    def applications_completed
      finder.completed.count
    end

    def applications_saved
      finder.with_owner.count
    end

    def applications_online_submission
      finder.where(
        submission_type: SubmissionType::ONLINE.to_s
      ).count
    end

    def applications_postal_submission
      finder.where(
        submission_type: SubmissionType::PRINT_AND_POST.to_s
      ).count
    end
  end
end
