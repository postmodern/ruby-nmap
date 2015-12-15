require 'spec_helper'
require 'cpe_examples'

require 'nmap/xml'
require 'nmap/service'

describe Service do
  let(:port) { @xml.host.open_ports.find { |port| port.number == 80 } }

  subject { port.service }

  describe "#name" do
    it "should parse the name" do
      expect(subject.name).to eq('http')
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
      expect(subject.product).to eq('Apache httpd')
    end
  end

  describe "#version" do
    it "should parse the version attribute" do
      expect(subject.version).to eq('2.4.7')
    end
  end

  describe "#extra_info" do
    it "should parse the extrainfo attribute" do
      expect(subject.extra_info).to eq('(Ubuntu)')
    end
  end

  describe "#hostname" do
    it "should parse the hostname attribute" do
      skip "need a service with the hostname attribute"
    end
  end

  describe "#os_type" do
    it "should parse the ostype attribute" do
      skip "need a service with the ostype attribute"
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

  describe "#to_s" do
    context "when #product and #version are not nil" do
      it "should include the product and version" do
        expect(subject.to_s).to be == "#{subject.product} #{subject.version}"
      end
    end
  end

  it_should_behave_like "CPE"
end
