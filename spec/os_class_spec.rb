require 'spec_helper'
require 'cpe_examples'

require 'nmap/os'
require 'cgi'

describe OS do
  subject { @xml.hosts.first.os.classes.first }

  describe "#type" do
    it "should parse the type" do
      expect(subject.type).to eq(:"general purpose")
    end
  end

  describe "#vendor" do
    it "should parse the vendor" do
      expect(subject.vendor).to eq('Linux')
    end
  end

  describe "#family" do
    it "should parse the family" do
      expect(subject.family).to eq(:Linux)
    end
  end

  describe "#gen" do
    it "should parse the gen" do
      expect(subject.gen).to eq(:'3.X')
    end
  end

  describe "#accuracy" do
    it "should parse the accuracy" do
      expect(subject.accuracy).to be_between(0,100)
    end
  end

  it_should_behave_like "CPE"
end
