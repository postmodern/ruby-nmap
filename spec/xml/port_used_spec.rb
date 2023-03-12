require 'spec_helper'
require 'nmap/xml/port_used'

describe Nmap::XML::PortUsed do
  let(:state)    { :open }
  let(:protocol) { :tcp }
  let(:port)     { 22 }

  subject { described_class.new(state,protocol,port) }

  describe "#to_i" do
    it "must return the port number" do
      expect(subject.to_i).to eq(port)
    end
  end

  describe "#to_int" do
    it "must return the port number" do
      expect(subject.to_int).to eq(port)
    end
  end
end
