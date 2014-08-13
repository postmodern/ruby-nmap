require 'spec_helper'
require 'cpe_examples'

require 'nmap/xml'
require 'nmap/service'

describe Service do
  subject { @xml.hosts.first.ports.first.service }

  describe "#name" do
    it "should parse the name" do
      expect(subject.name).to eq('ssh')
    end
  end

  describe "#ssl?" do
    it "should check the tunnel attribute" do
      skip "need a service that uses SSL"
    end
  end

  describe "#protocol" do
    it "should parse the proto attribute" do
      skip "need a service with the proto attribute"
    end
  end

  describe "#product" do
    it "should parse the product name attribute" do
      expect(subject.product).to eq('OpenSSH')
    end
  end

  describe "#version" do
    it "should parse the version attribute" do
      expect(subject.version).to eq('5.3p1 Debian 3ubuntu7')
    end
  end

  describe "#extra_info" do
    it "should parse the extrainfo attribute" do
      expect(subject.extra_info).to eq('protocol 2.0')
    end
  end

  describe "#hostname" do
    it "should parse the hostname attribute" do
      skip "need a service with the hostname attribute"
    end
  end

  describe "#os_type" do
    it "should parse the ostype attribute" do
      expect(subject.os_type).to eq('Linux')
    end
  end

  describe "#device_type" do
    it "should parse the devicetype attribute" do
      skip "need a service with the devicetype attribute"
    end
  end

  describe "#fingerprint_method" do
    it "should parse the method attribute" do
      expect(subject.fingerprint_method).to eq(:probed)
    end
  end

  describe "#confidence" do
    it "should parse the conf attribute" do
      expect(subject.confidence).to be_between(0,10)
    end
  end

  it_should_behave_like "CPE"
end
