task daily_tasks: :environment do
  log 'Starting daily tasks'
  log "Users count: #{User.count} / Applications count: #{C100Application.count}"

  Rake::Task['purge:users'].invoke

  Rake::Task['purge:applications'].invoke
  Rake::Task['purge:orphans'].invoke
  Rake::Task['purge:email_submissions_audit'].invoke

  Rake::Task['draft_reminders:first_email'].invoke
  Rake::Task['draft_reminders:last_email'].invoke

  log "Users count: #{User.count} / Applications count: #{C100Application.count}"
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

  task orphans: :environment do
    expire_after = Rails.configuration.x.orphans.expire_in_days
    log "Purging orphan applications older than #{expire_after} days"
    purged = C100Application.not_eligible_orphans.purge!(expire_after.days.ago)
    log "Purged #{purged.size} orphan applications"
  end

  task email_submissions_audit: :environment do
    expire_after = Rails.configuration.x.email_submissions_audit.expire_in_days
    log "Purging email submissions audit older than #{expire_after} days"
    purged = EmailSubmissionsAudit.purge!(expire_after.days.ago)
    log "Purged #{purged.size} email submissions audit records"
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

private

def log(message)
  puts "[#{Time.now}] #{message}"
end
