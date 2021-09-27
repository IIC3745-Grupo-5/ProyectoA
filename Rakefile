# frozen_string_literal: true

require 'rake/testtask'
require 'rubocop/rake_task'

task default: 'play'

task :play do
  ruby 'lib/main.rb'
end

Rake::TestTask.new(:test) do |task|
  task.pattern = 'test/*_test.rb'
  task.verbose = true
end

RuboCop::RakeTask.new(:lint) do |task|
  task.patterns = ['lib/**/*.rb']
  task.fail_on_error = true
end
