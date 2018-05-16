task :cucumber => :environment do
  vars = 'RAILS_ENV=test NOCOVERAGE=true'

  unless system("bundle exec cucumber")
    raise 'Mutation testing failed'
  end

  exit
end

task(:default).prerequisites << task(:cucumber)
