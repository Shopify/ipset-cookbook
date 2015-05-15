#!/usr/bin/env rake
require 'bundler/setup'
require 'foodcritic'
require 'stove/rake_task'
require 'rubocop/rake_task'

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

$stdout.sync = true
$stderr.sync = true

Stove::RakeTask.new
FoodCritic::Rake::LintTask.new
RuboCop::RakeTask.new

Dir.glob('lib/tasks/**/*.rb').each { |r| load r }
