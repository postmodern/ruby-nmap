require 'spec_helper'
require 'nmap/hostname'

describe Hostname do
  let(:name) { 'scanme.nmap.org' }

  describe "#user?" do
    subject { described_class.new('user', name) }

    it "should check if type is 'user'" do
      subject.user?.should == true
    end
  end

  describe "#user?" do
    subject { described_class.new('PTR', name) }

    it "should check if type is 'PTR'" do
      subject.ptr?.should == true
    end
  end

  describe "#to_s" do
    let(:type) { 'user' }

    subject { described_class.new(type, name) }

    it "should return the hostname" do
      subject.to_s.should == name
    end
  end
end
