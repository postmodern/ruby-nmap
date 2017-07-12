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

      expect(subject.arguments).to eq(['-p80,21,25'])
    end

    it "should format an Array of String ports" do
      subject.ports = %w[80 21 25]

      expect(subject.arguments).to eq(['-p80,21,25'])
    end

    it "should format an Array of Integer ports" do
      subject.ports = [80, 21, 25]

      expect(subject.arguments).to eq(['-p80,21,25'])
    end

    it "should format a Range of ports" do
      subject.ports = [80, 21..25]

      expect(subject.arguments).to eq(['-p80,21-25'])
    end
  end

  describe "#syn_discovery=" do
    it "should ignore empty port Arrays" do
      subject.syn_discovery = []

      expect(subject.arguments).to eq([])
    end

    it "should format a String of ports" do
      subject.syn_discovery = '80,21,25'

      expect(subject.arguments).to eq(%w[-PS80,21,25])
    end

    it "should format an Array of String ports" do
      subject.syn_discovery = %w[80 21 25]

      expect(subject.arguments).to eq(%w[-PS80,21,25])
    end

    it "should format an Array of Integer ports" do
      subject.syn_discovery = [80, 21, 25]

      expect(subject.arguments).to eq(%w[-PS80,21,25])
    end

    it "should format a Range of ports" do
      subject.syn_discovery = [80, 21..25]

      expect(subject.arguments).to eq(%w[-PS80,21-25])
    end

    it "should use default port if none specified" do
      subject.syn_discovery = true

      expect(subject.arguments).to eq(%w[-PS])
    end
  end

  describe "#ip_ping=" do
    it "should ignore empty proto Arrays" do
      subject.ip_ping = []

      expect(subject.arguments).to eq([])
    end

    it "should format a String of protos" do
      subject.ip_ping = 'ICMP,IGMP,TCP'

      expect(subject.arguments).to eq(%w[-POICMP,IGMP,TCP])
    end

    it "should format an Array of String protos" do
      subject.ip_ping = %w[ICMP IGMP TCP]

      expect(subject.arguments).to eq(%w[-POICMP,IGMP,TCP])
    end

    it "should use default port if none specified" do
      subject.ip_ping = true

      expect(subject.arguments).to eq(%w[-PO])
    end
  end
end
