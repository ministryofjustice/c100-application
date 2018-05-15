

task :travis => :environment do

  # start a webserver
  system("export DISPLAY=:99.0 && EXTERNAL_URL=http://localhost:8123 bundle exec cucumber")
  raise "#{cucumber} failed!" unless $?.exitstatus == 0

  Rake::Task['spec'].invoke
  Rake::Task['rubocop'].invoke
  Rake::Task['brakeman'].invoke
  Rake::Task['mutant'].invoke
end
