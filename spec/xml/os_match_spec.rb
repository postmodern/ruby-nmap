require 'spec_helper'
require 'nmap/xml/os_match'

describe Nmap::XML::OSMatch do
  subject { @xml.hosts.first.os.matches.first }

  let(:name)     { 'Linux 3.0' }
  let(:accuracy) { 94 }

  describe "#name" do
    it "must return the name attribute" do
      expect(subject.name).to eq(name)
    end
  end

  describe "#accuracy" do
    it "must return the accuracy attribute" do
      expect(subject.accuracy).to eq(accuracy)
    end
  end

  describe "#to_s" do
    it "should include the name and accuracy" do
      expect(subject.to_s).to eq("#{name} (#{accuracy}%)")
    end
  end
end
