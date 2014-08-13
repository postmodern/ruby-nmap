require 'spec_helper'

require 'nmap/version'

describe Nmap do
  it "should have a VERSION constant" do
    expect(subject.const_defined?('VERSION')).to be_truthy
  end
end
