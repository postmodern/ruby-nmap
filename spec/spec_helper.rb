gem 'rspec', '~> 2.4'
require 'rspec'

require 'nmap/version'
require 'nmap/xml'
include Nmap

require 'helpers/xml'

RSpec.configure do |spec|
  spec.include Helpers

  spec.before(:all) do
    @xml = XML.new('spec/scan.xml')
  end
end
