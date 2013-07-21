require 'spec_helper'
require 'cpe_examples'

require 'nmap/xml'
require 'nmap/service'

describe Service do
  subject { @xml.hosts.first.ports.first.service }

  it "should parse the name" do
    subject.name.should == 'ssh'
  end

  it "should parse the fingerprint method" do
    subject.fingerprint_method.should == :probed
  end

  it "should parse the confidence" do
    subject.confidence.should be_between(0,10)
  end

  it "should parse the product name" do
    subject.product.should == 'OpenSSH'
  end

  it "should parse the version" do
    subject.version.should == '5.3p1 Debian 3ubuntu7'
  end

  it_should_behave_like "CPE"
end
