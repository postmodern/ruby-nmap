require 'rspec'
require 'simplecov'
SimpleCov.start

require 'nmap/version'
require 'nmap/xml'
include Nmap

RSpec.configure do |spec|
  spec.before(:all) do
    @xml       = XML.open('spec/fixtures/scan.xml')
    @local_xml = XML.open('spec/fixtures/local_scan.xml')
  end
end
