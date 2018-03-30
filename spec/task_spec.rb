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

  describe "#sctp_init_ping" do
    context "when given a Boolean" do
      it "should emit the -PY option flag" do
        subject.sctp_init_ping = true

        expect(subject.arguments).to eq(%w[-PY])
      end
    end

    context "when given an Array of Integers" do
      let(:ports) { [80, 21, 25] }

      it "should emit the -PY option flag with the Integer ports" do
        subject.sctp_init_ping = ports

        expect(subject.arguments).to eq(['-PY', ports.join(',')])
      end
    end

    context "when given an Array containing a Range" do
      let(:ports) { [80, 21..25] }

      it "should emit the -PY option flag with the Integer ports" do
        subject.sctp_init_ping = ports

        expect(subject.arguments).to eq(['-PY', "#{ports[0]},#{ports[1].begin}-#{ports[1].end}"])
      end
    end
  end
end
