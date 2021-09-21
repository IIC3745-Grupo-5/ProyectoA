# frozen_string_literal: true

require 'rubocop/rake_task'

task default: %w[lint play]

task :play do
  ruby 'lib/main.rb'
end

task default: %w[lint test]

task :test do
  # ruby 'test/board_model.rb'
end

RuboCop::RakeTask.new(:lint) do |task|
  task.patterns = ['lib/**/*.rb', 'test/**/*.rb']
  task.fail_on_error = false
end
