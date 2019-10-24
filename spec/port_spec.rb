require 'spec_helper'
require 'scripts_examples'

require 'nmap/port'

describe Port do
  subject { @xml.hosts.first.ports.first }

  describe "#protocol" do
    it "should parse the protocol" do
      expect(subject.protocol).to eq(:tcp)
    end
  end

  describe "#number" do
    it "should parse the port number" do
      expect(subject.number).to eq(22)
    end
  end

  describe "#state" do
    it "should parse the state" do
      expect(subject.state).to eq(:open)
    end
  end

  describe "#reason" do
    it "should parse the reason" do
      expect(subject.reason).to eq('syn-ack')
    end
  end

  describe "#reason_ttl" do
    it "should parse the reason_ttl attribute" do
      expect(subject.reason_ttl).to be_kind_of(Integer)
    end
  end

  describe "#service" do
    subject { super().service }

    it "should return a Service object" do
      expect(subject).to be_kind_of(Service)
    end
  end

  include_examples "#scripts"
  include_examples "#script_data"

  describe "#inspect" do
    it "should include the number" do
      expect(subject.inspect).to include(subject.number.to_s)
    end
  end
end
