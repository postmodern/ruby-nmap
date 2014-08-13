require 'spec_helper'
require 'sequence_examples'

require 'nmap/ip_id_sequence'

describe IpIdSequence do
  subject { @xml.hosts.first.ip_id_sequence }

  describe "#description" do
    it "should parse the description" do
      expect(subject.description).to eq("All zeros")
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
