require 'spec_helper'
require 'nmap/scan_task'

describe ScanTask do
  let(:name)       { 'SYN Stealth Scan' }
  let(:end_time)   { Time.now }
  let(:duration)   { 10 }
  let(:start_time) { end_time - duration }
  let(:extrainfo)  { '1000 total ports' }

  subject do
    described_class.new(
      name,
      start_time,
      end_time,
      extrainfo
    )
  end

  describe "#duration" do
    it "should be > 0" do
      subject.duration.should > 0
    end

    it "should be the time between the start_time and end_time" do
      (subject.start_time + subject.duration).should == subject.end_time
    end
  end

  describe "#to_s" do
    it "should include the start_time, name and extrainfo" do
      subject.to_s.should == "#{start_time}: #{name} (#{extrainfo})"
    end
  end
end
