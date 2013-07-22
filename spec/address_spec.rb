require 'spec_helper'
require 'nmap/address'

describe Address do
  describe "#to_s" do
    let(:addr) { '127.0.0.1' }

    subject { described_class.new(:ipv4, addr) }

    it "should return the address" do
      subject.to_s.should == addr
    end
  end
end
