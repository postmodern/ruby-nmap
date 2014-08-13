require 'spec_helper'
require 'nmap/address'

describe Address do
  describe "#to_s" do
    let(:addr) { '127.0.0.1' }

    subject { described_class.new(:ipv4, addr) }

    it "should return the address" do
      expect(subject.to_s).to eq(addr)
    end
  end
end
