require 'spec_helper'
require 'cpe_examples'

require 'nmap/xml'
require 'nmap/service'

describe Service do
  subject { @xml.hosts.first.ports.first.service }

  describe "#name" do
    it "should parse the name" do
      subject.name.should == 'ssh'
    end
  end

  describe "#ssl?" do
    it "should check the tunnel attribute" do
      pending "need a service that uses SSL"
    end
  end

  describe "#protocol" do
    it "should parse the proto attribute" do
      pending "need a service with the proto attribute"
    end
  end

  describe "#product" do
    it "should parse the product name attribute" do
      subject.product.should == 'OpenSSH'
    end
  end

  describe "#version" do
    it "should parse the version attribute" do
      subject.version.should == '5.3p1 Debian 3ubuntu7'
    end
  end

  describe "#extra_info" do
    it "should parse the extrainfo attribute" do
      subject.extra_info.should == 'protocol 2.0'
    end
  end

  describe "#hostname" do
    it "should parse the hostname attribute" do
      pending "need a service with the hostname attribute"
    end
  end

  describe "#os_type" do
    it "should parse the ostype attribute" do
      subject.os_type.should == 'Linux'
    end
  end

  describe "#device_type" do
    it "should parse the devicetype attribute" do
      pending "need a service with the devicetype attribute"
    end
  end

  describe "#fingerprint_method" do
    it "should parse the method attribute" do
      subject.fingerprint_method.should == :probed
    end
  end

  describe "#confidence" do
    it "should parse the conf attribute" do
      subject.confidence.should be_between(0,10)
    end
  end

  it_should_behave_like "CPE"
end
