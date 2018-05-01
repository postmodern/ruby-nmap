require 'spec_helper'
require 'nmap/task'

describe Task do
  describe "#ports=" do
    context "when given an empty Array" do
      before { subject.ports = [] }

      it "should ignore empty port Arrays" do
        subject.ports = []

        expect(subject.arguments).to eq([])
      end
    end

    context "when given a String" do
      let(:ports) { '80,21,25' }

      before { subject.ports = ports }

      it "should emit the String as is" do
        expect(subject.arguments).to eq(['-p', ports])
      end
    end

    context "when given an Array of Strings" do
      let(:ports) { %w[80 21 25] }

      before { subject.ports = ports }

      it "should format an Array of String ports" do
        expect(subject.arguments).to eq(['-p', ports.join(',')])
      end
    end

    context "when given an Array of Integers" do
      let(:ports) { [80, 21, 25] }

      before { subject.ports = ports }

      it "should format an Array of Integer ports" do
        expect(subject.arguments).to eq(['-p', ports.join(',')])
      end
    end

    context "when given an Array containing a Range" do
      let(:ports) { [80, 21..25] }

      before { subject.ports = ports }

      it "should format the Range" do
        expect(subject.arguments).to eq([
          '-p', "#{ports[0]},#{ports[1].begin}-#{ports[1].end}"
        ])
      end
    end
  end

  shared_examples "optional port range" do |flag,method|
    before { subject.send(:"#{method}=",ports) }

    context "when given a Boolean" do
      let(:ports) { true }

      it "should emit the '#{flag}' option flag" do
        expect(subject.arguments).to eq([flag])
      end
    end

    context "when given an empty Array" do
      let(:ports) { [] }

      it "should emit the '#{flag}' option flag" do
        expect(subject.arguments).to eq([flag])
      end
    end

    context "when given an Array of Integers" do
      let(:ports) { [80, 21, 25] }

      it "should emit the '#{flag}' option flag with the Integer ports" do
        expect(subject.arguments).to eq(["#{flag}#{ports.join(',')}"])
      end
    end

    context "when given an Array containing a Range" do
      let(:ports) { [80, 21..25] }

      it "should emit the '#{flag}' option flag with the Integer ports" do
        expect(subject.arguments).to eq([
          "#{flag}#{ports[0]},#{ports[1].begin}-#{ports[1].end}"
        ])
      end
    end
  end

  describe "#syn_discovery" do
    include_examples "optional port range", '-PS', :syn_discovery
  end

  describe "#ack_discovery" do
    include_examples "optional port range", '-PA', :ack_discovery
  end

  describe "#udp_discovery" do
    include_examples "optional port range", '-PU', :udp_discovery
  end

  describe "#sctp_init_ping" do
    include_examples "optional port range", '-PY', :sctp_init_ping
  end

  describe "#ip_ping" do
    before { subject.ip_ping = protocols }

    context "when given a Boolean" do
      let(:protocols) { true }

      it "should emit the '-PO' option flag" do
        expect(subject.arguments).to eq(['-PO'])
      end
    end

    context "when given an empty Array" do
      let(:protocols) { [] }

      it "should emit the '-PO' option flag" do
        expect(subject.arguments).to eq(['-PO'])
      end
    end

    context "when given an Array of Integers" do
      let(:protocols) { [80, 21, 25] }

      it "should emit the '-PO' option flag with the Integer ports" do
        expect(subject.arguments).to eq(["-PO#{protocols.join(',')}"])
      end
    end

    context "when given an Array containing a Range" do
      let(:protocols) { [80, 21..25] }

      it "should emit the '-PO' option flag with the Integer ports" do
        expect(subject.arguments).to eq([
          "-PO#{protocols[0]},#{protocols[1].begin}-#{protocols[1].end}"
        ])
      end
    end
  end
end
