require 'spec_helper'
require 'nmap/scan'

describe Scan do
  let(:type)     { :syn }
  let(:protocol) { :tcp }

  describe "#initialize" do
    subject { described_class.new(type,protocol) }

    it "should accept a type and protocol" do
      subject.type.should == type
      subject.protocol.should == protocol
    end

    it "should default services to []" do
      subject.services.should == []
    end
  end

  describe "#to_s" do
    subject { described_class.new(type,protocol) }

    it "should include the type and protocol" do
      subject.to_s.should == "#{protocol} #{type}"
    end
  end
end
