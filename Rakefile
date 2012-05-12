#!/usr/bin/env rake
require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new do |tt|
  tt.pattern = 'spec/*_spec.rb'
  tt.verbose = true 
  tt.libs << "spec"
end
