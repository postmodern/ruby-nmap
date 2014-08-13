require 'rspec'
require 'simplecov'
SimpleCov.start

require 'nmap/version'
require 'nmap/xml'
include Nmap

RSpec::Matchers.define :be_one_of do |*values|
  match do |value|
    values.include?(value)
  end

  description { "be one of: #{expected.join(', ')}" }
end

RSpec.configure do |spec|
  spec.before(:all) do
    @xml = XML.new('spec/scan.xml')
  end
end
