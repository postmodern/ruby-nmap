require 'spec_helper'
require 'nmap/scan'

describe Scan do
  let(:type)     { :syn }
  let(:protocol) { :tcp }

  describe "#initialize" do
    subject { described_class.new(type,protocol) }

    it "should accept a type and protocol" do
      expect(subject.type).to eq(type)
      expect(subject.protocol).to eq(protocol)
    end

    it "should default services to []" do
      expect(subject.services).to eq([])
    end
  end

  describe "#to_s" do
    subject { described_class.new(type,protocol) }

    it "should include the type and protocol" do
      expect(subject.to_s).to eq("#{protocol} #{type}")
    end
  end
end
