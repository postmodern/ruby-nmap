require 'spec_helper'

require 'nmap/version'

describe Nmap do
  it "should have a VERSION constant" do
    subject.const_defined?('VERSION').should be_true
  end
end
