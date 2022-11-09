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

task :spec    => 'spec/fixtures/scan.xml'
task :test    => :spec
task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new  
task :doc => :yard

file 'spec/fixtures/scan.xml' do |t|
  puts ">>> Scanning scanme.nmap.org ..."
  sh "sudo nmap -v -sS -sU -A -O --script ssh2-enum-algos,ssh-hostkey -oX #{t.name} scanme.nmap.org"
end

file 'spec/fixtures/down_host_scan.xml' do |t|
  puts ">>> Scanning 225.0.0.1 ..."
  sh "sudo nmap -v -sS -oX #{t.name} 225.0.0.1"
end
