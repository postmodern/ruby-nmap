require 'spec_helper'
require 'nmap/hostname'

describe Hostname do
  describe "#to_s" do
    let(:type) { :user }
    let(:name) { 'scanme.nmap.org' }

    subject { described_class.new(type, name) }

    it "should return the hostname" do
      subject.to_s.should == name
    end
  end
end
