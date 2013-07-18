require 'spec_helper'
require 'nmap/port'

describe Port do
  let(:xml) { XML.new(Helpers::SCAN_FILE) }

  subject { xml.hosts.first.ports.first }

  it "should parse the protocol" do
    subject.protocol.should == :tcp
  end

  it "should parse the port number" do
    subject.number.should == 21
  end

  it "should parse the state" do
    subject.state.should == :closed
  end

  it "should parse the reason" do
    subject.reason.should == 'reset'
  end

  it "should parse the detected service" do
    subject.service.name.should == 'ftp'
  end

  describe "#inspect" do
    it "should include the number" do
      subject.inspect.should include(subject.number.to_s)
    end
  end

  context "when NSE scripts are ran" do
    let(:xml) { XML.new(Helpers::NSE_FILE) }

    it "should parse the output of scripts" do
      subject.scripts.should_not be_empty

      subject.scripts.keys.should_not include(nil)
      subject.scripts.values.should_not include(nil)
    end
  end
end
