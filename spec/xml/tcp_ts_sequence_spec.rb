require 'spec_helper'
require 'xml/sequence_examples'

require 'nmap/xml/tcp_ts_sequence'

describe Nmap::XML::TcpTsSequence do
  subject { @xml.hosts.first.tcp_ts_sequence }

  describe "#description" do
    it "should parse the description" do
      expect(subject.description).to eq("1000HZ").or(eq('other'))
    end
  end

  describe "#to_s" do
    let(:description_regexp) do
      /"[^"]+"/
    end

    let(:values_regexp) do
      /\[\d+(, \d+){5}\]/
    end

    let(:regexp) do
      /^description=#{description_regexp} values=#{values_regexp}$/
    end

    it "should contain the description and values" do
      expect(subject.to_s).to match(regexp)
    end
  end

  it_should_behave_like "Sequence"
end
