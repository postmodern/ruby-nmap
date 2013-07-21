require 'spec_helper'
require 'nmap/tcp_ts_sequence'

describe TcpTsSequence do
  subject { @xml.hosts.first.tcp_ts_sequence }

  it "should be accessible from host objects" do
    subject.should be_kind_of(TcpTsSequence)
  end

  it "should parse the description" do
    subject.description.should == "1000HZ"
  end

  it "should parse the values" do
    subject.values.should == [
      0x35FAF70B,
      0x35FAF76E,
      0x35FAF7D4,
      0x35FAF838,
      0x35FAF89C,
      0x35FAF900
    ]
  end
end
