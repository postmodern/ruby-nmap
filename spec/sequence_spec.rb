require 'spec_helper'

require 'nmap/tcp_sequence'
require 'nmap/tcp_ts_sequence'
require 'nmap/ip_id_sequence'

describe TcpSequence do
  let(:xml) { XML.new(Helpers::SCAN_FILE) }

  subject { xml.hosts.first.tcp_sequence }

  it "should be accessible from host objects" do
    subject.should be_kind_of(TcpSequence)
  end

  it "should parse the index" do
    subject.index.should == 25
  end

  it "should parse the difficulty description" do
    subject.difficulty.should == "Good luck!"
  end

  it "should parse the values" do
    subject.values.should == [
      0xAF1B39BD,
      0xAF1C33BD,
      0xAF1F21BD,
      0xAF201BBD,
      0xAF2115BD,
      0xAF220FBD
    ]
  end
end

describe IpidSequence do
  let(:xml) { XML.new(Helpers::SCAN_FILE) }

  subject { xml.hosts.first.ip_id_sequence }

  it "should be accessible from host objects" do
    subject.should be_kind_of(IpidSequence)
  end

  it "should parse the description" do
    subject.description.should == "Incremental"
  end

  it "should parse the values" do
    subject.values.should == [0x1FB0, 0x1FB2, 0x1FB4, 0x1FB6, 0x1FB8, 0x1FBA]
  end
end

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
