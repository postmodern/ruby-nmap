require 'spec_helper'
require 'nmap/tcp_ts_sequence'

describe TcpTsSequence do
  let(:xml) { XML.new(Helpers::SCAN_FILE) }

  subject { xml.hosts.first.tcp_ts_sequence }

  it "should be accessible from host objects" do
    subject.should be_kind_of(TcpTsSequence)
  end

  it "should parse the description" do
    subject.description.should == "2HZ"
  end

  it "should parse the values" do
    subject.values.should == [0x1858, 0x1858, 0x1859, 0x1859, 0x1859, 0x1859]
  end
end
