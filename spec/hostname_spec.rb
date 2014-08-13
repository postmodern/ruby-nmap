require 'spec_helper'
require 'nmap/hostname'

describe Hostname do
  let(:name) { 'scanme.nmap.org' }

  describe "#user?" do
    subject { described_class.new('user', name) }

    it "should check if type is 'user'" do
      expect(subject.user?).to eq(true)
    end
  end

  describe "#user?" do
    subject { described_class.new('PTR', name) }

    it "should check if type is 'PTR'" do
      expect(subject.ptr?).to eq(true)
    end
  end

  describe "#to_s" do
    let(:type) { 'user' }

    subject { described_class.new(type, name) }

    it "should return the hostname" do
      expect(subject.to_s).to eq(name)
    end
  end
end
