desc "Quick post deploy tests to verify deployment successful"
namespace :test do
  task smoke: :environment do
    if system "bundle exec cucumber features/  --tags @smoketest"
      puts "Smoke test passed"
    else
      raise "Smoke tests failed"
    end
  end
end
