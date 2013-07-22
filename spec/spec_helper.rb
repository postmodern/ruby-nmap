require 'rspec'
require 'simplecov'
SimpleCov.start

require 'nmap/version'
require 'nmap/xml'
include Nmap

RSpec::Matchers.define :be_between do |min,max|
  match do |value|
    (value >= min) && (value <= max)
  end
end

RSpec::Matchers.define :all_be_between do |min,max|
  match do |values|
    values.all? { |value| (value >= min) && (value <= max) }
  end
end

RSpec::Matchers.define :be_one_of do |*values|
  match do |value|
    values.include?(value)
  end

  description { "be one of: #{expected.join(', ')}" }
end

RSpec::Matchers.define :all_be_kind_of do |base_class|
  match do |values|
    values.all? { |value| value.kind_of?(base_class) }
  end
end

RSpec.configure do |spec|
  spec.before(:all) do
    @xml = XML.new('spec/scan.xml')
  end
end
