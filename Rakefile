# encoding: utf-8

require 'rubygems'

begin
  require 'bundler/setup'
rescue LoadError => e
  warn e.message
  warn "Run `gem install bundler` to install Bundler"
  exit -1
end

require 'rake'
require 'rake/clean'

CLEAN.include('spec/*.xml')

require 'rubygems/tasks'

Gem::Tasks.new

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

task :spec    => 'spec/scan.xml'
task :test    => :spec
task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new  
task :doc => :yard

file 'spec/scan.xml' do
  puts ">>> Scanning scanme.nmap.org ..."
  sh 'sudo nmap -v -sS -sU -A -O -oX spec/scan.xml scanme.nmap.org'
end
