namespace :test do
# test:all is already defined by rails
  task all_the_things: :environment do
    # Rake::Task['rubocop'].invoke
    # Rake::Task['brakeman'].invoke
    # Rake::Task['rspec'].invoke

    # max_retries = 3
    # retries = 0
    # begin
    #   Rake::Task['cucumber'].invoke
    # rescue
    #   retries += 1
    #   if retries <= max_retries
    #     puts "Cucumber tests failed, retrying... (##{retries})"
    #     Rake::Task['cucumber'].reenable # in case you're going to invoke the same task again
    #     retry
    #   else
    #     puts "Cucumber tests failed after #{max_retries} retries"
    #     raise
    #   end
    # end

    # Rake::Task['mutant'].invoke # always disabled
  end
end

# The following is the default task to run if none specified, so:
#   `bundle exec rake`
# will be equivalent to:
#   `bundle exec rake test:all_the_things`
#
task(:default).prerequisites.clear << task('test:all_the_things')

