require 'spec_helper'
require 'nmap/xml/scan_task'

describe Nmap::XML::ScanTask do
  let(:name)       { 'SYN Stealth Scan' }
  let(:end_time)   { Time.now }
  let(:duration)   { 10 }
  let(:start_time) { end_time - duration }
  let(:extra_info)  { '1000 total ports' }

  subject do
    described_class.new(
      name,
      start_time,
      end_time,
      extra_info
    )
  end

  describe "#duration" do
    it "should be > 0" do
      expect(subject.duration).to be > 0
    end

    it "should be the time between the start_time and end_time" do
      expect(subject.start_time + subject.duration).to eq(subject.end_time)
    end
  end

  describe "#to_s" do
    it "should include the start_time, name and extra_info" do
      expect(subject.to_s).to eq("#{start_time}: #{name} (#{extra_info})")
    end
  end
end
