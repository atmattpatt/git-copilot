# frozen_string_literal: true

require "fileutils"

require "bundler/gem_tasks"
require "cucumber/rake/task"
require "rspec/core/rake_task"
require "rubocop/rake_task"

Cucumber::Rake::Task.new(:features)

RSpec::Core::RakeTask.new(:spec)

RuboCop::RakeTask.new(:rubocop)

task :clean do
  FileUtils.rm_rf("coverage")
end

task default: %i[clean features spec rubocop]
