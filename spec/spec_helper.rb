require 'rspec'
require 'simplecov'
SimpleCov.start

require 'nmap/version'
require 'nmap/xml'
include Nmap

RSpec.configure do |spec|
  spec.before(:all) do
    @xml = XML.new('spec/scan.xml')
  end
end
