require 'spec_helper'
require 'nmap/port'

describe Port do
  subject { @xml.hosts.first.ports.first }

  it "should parse the protocol" do
    subject.protocol.should == :tcp
  end

  it "should parse the port number" do
    subject.number.should == 22
  end

  it "should parse the state" do
    subject.state.should == :open
  end

  it "should parse the reason" do
    subject.reason.should == 'syn-ack'
  end

  describe "#service" do
    subject { super().service }

    it "should return a Service object" do
      subject.should be_kind_of(Service)
    end
  end

  include_examples "#scripts"

  describe "#inspect" do
    it "should include the number" do
      subject.inspect.should include(subject.number.to_s)
    end
  end
end
