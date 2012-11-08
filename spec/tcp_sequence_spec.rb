require 'spec_helper'
require 'nmap/tcp_sequence'

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
