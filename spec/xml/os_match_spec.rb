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

  describe "#line" do
    it "must return the parsed line attribute" do
      expect(subject.line).to eq(48063)
    end
  end

  describe "#os_class" do
    it "must return a Nmap::XML::OSClass object" do
      expect(subject.os_class).to be_kind_of(Nmap::XML::OSClass)
    end
  end

  describe "#to_s" do
    it "should include the name and accuracy" do
      expect(subject.to_s).to eq("#{name} (#{accuracy}%)")
    end
  end
end
