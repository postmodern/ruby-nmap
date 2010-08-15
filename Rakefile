require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:development, :doc)
rescue Bundler::BundlerError => e
  STDERR.puts e.message
  STDERR.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rubygems'
require 'rake'
require './lib/nmap/version.rb'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = 'ruby-nmap'
  gem.version = Nmap::VERSION
  gem.summary = %Q{A Ruby interface to Nmap.}
  gem.description = %Q{A Ruby interface to Nmap, the exploration tool and security / port scanner.}
  gem.email = 'postmodern.mod3@gmail.com'
  gem.homepage = 'http://github.com/sophsec/ruby-nmap'
  gem.authors = ['Postmodern']
  gem.add_dependency 'nokogiri', '>= 1.3.0'
  gem.add_dependency 'rprogram', '>= 0.1.8'
  gem.add_development_dependency 'rspec', '>= 1.3.0'
  gem.add_development_dependency 'yard', '>= 0.5.3'
  gem.requirements = ['nmap, 4.xx or greater']
  gem.has_rdoc = 'yard'
end
Jeweler::GemcutterTasks.new

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs += ['lib', 'spec']
  spec.spec_files = FileList['spec/**/*_spec.rb']
  spec.spec_opts = ['--options', '.specopts']
end

task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new
