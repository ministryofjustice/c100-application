task :cucumber => :environment do
  vars = 'RAILS_ENV=test NOCOVERAGE=true'

  unless system("bundle exec cucumber")
    raise 'Mutation testing failed'
  end

  exit
end

task :echo_env_and_exit => :environment do
  puts "HEROKU_APP_NAME=#{HEROKU_APP_NAME}"
  raise 'deliberate exception to stop the pipeline'
end

task(:default).prerequisites << task(:echo_env_and_exit)
