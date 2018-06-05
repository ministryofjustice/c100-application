task :daily_tasks do
  log 'Starting daily tasks'

  Rake::Task['purge:users'].invoke

  Rake::Task['purge:applications'].invoke

  Rake::Task['draft_reminders:first_email'].invoke
  Rake::Task['draft_reminders:last_email'].invoke

  Rake::Task['stats:cumulative_data'].invoke

  log 'Finished daily tasks'
end

namespace :purge do
  task users: :environment do
    expire_after = Rails.configuration.x.users.expire_in_days
    log "Purging users who have not logged in for #{expire_after} days"
    purged = User.purge!(expire_after.days.ago)
    log "Purged #{purged.size} users"
  end

  task applications: :environment do
    expire_after = Rails.configuration.x.drafts.expire_in_days
    log "Purging applications older than #{expire_after} days"
    purged = C100Application.purge!(expire_after.days.ago)
    log "Purged #{purged.size} applications"
  end
end

namespace :draft_reminders do
  task first_email: :environment do |task_name|
    rule_set = C100App::ReminderRuleSet.first_reminder

    log "#{task_name} - Count: #{rule_set.count}"
    C100App::DraftReminders.new(rule_set: rule_set).run
  end

  task last_email: :environment do |task_name|
    rule_set = C100App::ReminderRuleSet.last_reminder

    log "#{task_name}  - Count: #{rule_set.count}"
    C100App::DraftReminders.new(rule_set: rule_set).run
  end
end

namespace :stats do
  task cumulative_data: :environment do
    log 'Processing cumulative data points...'
    CumulativeData.process!
  end
end

private

def log(message)
  puts "[#{Time.now}] #{message}"
end
