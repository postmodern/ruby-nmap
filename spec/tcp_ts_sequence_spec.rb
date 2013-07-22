require 'spec_helper'
require 'sequence_examples'

require 'nmap/tcp_ts_sequence'

describe TcpTsSequence do
  subject { @xml.hosts.first.tcp_ts_sequence }

  it "should parse the description" do
    subject.description.should == "1000HZ"
  end

  it_should_behave_like "Sequence"
end
