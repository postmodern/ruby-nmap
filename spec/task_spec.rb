require 'spec_helper'
require 'nmap/task'

describe Task do
  describe "#ports=" do
    it "should ignore empty port Arrays" do
      subject.ports = []

      expect(subject.arguments).to eq([])
    end

    it "should format a String of ports" do
      subject.ports = '80,21,25'

      expect(subject.arguments).to eq(%w[-p 80,21,25])
    end

    it "should format an Array of String ports" do
      subject.ports = %w[80 21 25]

      expect(subject.arguments).to eq(%w[-p 80,21,25])
    end

    it "should format an Array of Integer ports" do
      subject.ports = [80, 21, 25]

      expect(subject.arguments).to eq(%w[-p 80,21,25])
    end

    it "should format a Range of ports" do
      subject.ports = [80, 21..25]

      expect(subject.arguments).to eq(%w[-p 80,21-25])
    end
  end
end
