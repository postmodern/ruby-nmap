require 'spec_helper'
require 'nmap/uptime'

describe Uptime do
  describe "#to_s" do
    let(:seconds)   { 920430 }
    let(:last_boot) { Time.parse("2013-07-10 08:34:03 -0700") }

    subject { described_class.new(seconds,last_boot) }

    it "should convert the uptipe to a String" do
      expect(subject.to_s).to eq("uptime: #{seconds} (#{last_boot})")
    end
  end
end
