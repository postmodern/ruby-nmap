require 'spec_helper'
require 'nmap/run_stat'

describe RunStat do
  subject { @xml.run_stats.first }

  describe "#to_s" do
    let(:end_time)    { Time.parse('2013-07-21 00:14:33 -0700') }
    let(:elapsed)     { '1145.71' }
    let(:summary) do
      "Nmap done at Sun Jul 21 00:14:33 2013; 1 IP address (1 host up) scanned in 1145.71 seconds"
    end
    let(:exit_status) { 'success' }

    subject { described_class.new(end_time,elapsed,summary,exit_status) }

    it "should convert the RunStat to a String" do
      expect(subject.to_s).to eq("#{end_time} #{elapsed} #{exit_status}")
    end
  end
end
