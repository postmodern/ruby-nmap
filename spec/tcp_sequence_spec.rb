require 'spec_helper'
require 'sequence_examples'

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

  it_should_behave_like "Sequence"
end
