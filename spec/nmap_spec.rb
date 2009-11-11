require 'nmap/version'

require 'spec_helper'

describe Nmap do
  it "should have a VERSION constant" do
    Nmap.const_defined?('VERSION').should == true
  end
end
