# frozen_string_literal: true

require 'rake/testtask'
require 'rubocop/rake_task'

task default: 'test'

Rake::TestTask.new do |task|
  task.pattern = 'test/*_test.rb'
end

task :play do
  ruby 'lib/main.rb'
end

RuboCop::RakeTask.new(:lint) do |task|
  task.patterns = ['lib/**/*.rb', 'test/**/*.rb']
  task.fail_on_error = false
end
