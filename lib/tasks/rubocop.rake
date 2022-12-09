if %w(development test).include?(Rails.env) && Gem.loaded_specs.key?('rubocop')
  require 'rubocop/rake_task'
  puts "in rake task" 
  RuboCop::RakeTask.new do |task|
    task.requires << 'rubocop-performance'
  end
  puts "finished rake task"
end
