if %w(development test).include?(Rails.env) && Gem.loaded_specs.key?('rubocop')
  puts 'starting rubocop.rake'
  require 'rubocop/rake_task'
  puts 'required rubocop/rake_task'
  RuboCop::RakeTask.new
  puts 'did RuboCop::RakeTask.new'
end
