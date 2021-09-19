# frozen_string_literal: true

require 'rubocop/rake_task'

task default: %w[lint test]

# start adding tasks here
task :test do
  # ruby 'test/clock_display_test.rb' (this is an example)
end
# stop adding tasks here

RuboCop::RakeTask.new(:lint) do |task|
  task.patterns = ['lib/**/*.rb', 'test/**/*.rb']
  task.fail_on_error = false
end
