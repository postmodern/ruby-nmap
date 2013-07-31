require 'spec_helper'
require 'nmap/uptime'

describe Uptime do
  describe "#to_s" do
    let(:seconds)  { 920430 }
    let(:lastboot) { Time.parse("2013-07-10 08:34:03 -0700") }

    subject { described_class.new(seconds,lastboot) }

    it "should convert the uptipe to a String" do
      subject.to_s.should == "uptime: #{seconds} (#{lastboot})"
    end
  end
end
