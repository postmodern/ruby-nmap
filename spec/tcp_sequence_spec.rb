require 'spec_helper'
require 'nmap/tcp_sequence'

describe TcpSequence do
  subject { @xml.hosts.first.tcp_sequence }

  it "should be accessible from host objects" do
    subject.should be_kind_of(TcpSequence)
  end

  it "should parse the index" do
    subject.index.should == 195
  end

  it "should parse the difficulty description" do
    subject.difficulty.should == "Good luck!"
  end

  it "should parse the values" do
    subject.values.should == [
      0x48496039,
      0x4823E13C,
      0x487362E9,
      0x489580F0,
      0x4906414A,
      0x48C579D8
    ]
  end
end
