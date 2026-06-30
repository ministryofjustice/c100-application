desc "Tests to check applications works at runtime"
namespace :test do
  task :functional do
    if system "bundle exec cucumber features/  --tags @end-to-end"
      puts "Functional tests passed"
    else
      raise "Functional tests failed"
      end
  end
end
