require 'spec_helper'
require 'scripts_examples'

require 'nmap/xml'
require 'nmap/host'

describe Host do
  subject { @xml.hosts.first }

  describe "#start_time" do
    it "should parse the start_time" do
      expect(subject.start_time).to be > Time.at(0)
    end
  end

  describe "#end_time" do
    it "should parse the end_time" do
      expect(subject.end_time).to be > Time.at(0)
      expect(subject.end_time).to be > subject.start_time
    end
  end

  describe "#uptime" do
    subject { super().uptime }

    it "should return an Uptime object" do
      expect(subject).to be_kind_of(Uptime)
    end

    it "should parse the seconds attribute" do
      expect(subject.seconds).to be > 0
    end

    it "should parse the lastboot attribute" do
      expect(subject.last_boot).to be_kind_of(Time)
    end
  end

  describe "#tcp_sequence" do
    subject { super().tcp_sequence }

    it { is_expected.to be_kind_of(TcpSequence) }
  end

  describe "#ip_ip_sequence" do
    subject { super().ip_id_sequence }

    it { is_expected.to be_kind_of(IpIdSequence) }
  end

  describe "#tcp_ts_sequence" do
    subject { super().tcp_ts_sequence }

    it { is_expected.to be_kind_of(TcpTsSequence) }
  end

  describe "#status" do
    subject { super().status }

    it "should parse the state" do
      expect(subject.state).to eq(:up).or eq(:down)
    end

    it "should parse the reason" do
      expect(subject.reason).to eq('syn-ack').or \
                                eq('timestamp-reply').or \
                                eq('echo-reply').or \
                                eq('reset')
    end

    it "should parse the reason_ttl" do
      expect(subject.reason_ttl).to be_kind_of(Integer)
    end
  end

  let(:ipv4) { '45.33.32.156' }

  describe "#addresses" do
    subject { super().addresses.first }

    it "should parse the type" do
      expect(subject.type).to eq(:ipv4)
    end

    it "should parser the addr" do
      expect(subject.addr).to eq(ipv4)
    end
  end

  describe "#mac" do
    it "should parse the first MAC address" do
      skip "need a host with address[@addrtype='mac']"
    end
  end

  describe "#ipv6" do
    it "should parse the first IPv6 address" do
      skip "need a host with address[@addrtype='ipv6']"
    end
  end

  describe "#ipv4" do
    it "should parse the IPv4 address" do
      expect(subject.ipv4).to eq(ipv4)
    end
  end

  describe "#ip" do
    it "should have an IP" do
      expect(subject.ip).to eq(ipv4)
    end
  end

  describe "#address" do
    it "should have an address" do
      expect(subject.address).to eq(ipv4)
    end
  end

  describe "#hostnames" do
    subject { super().hostnames }

    it { is_expected.not_to be_empty }

    it "should parse the type" do
      expect(subject.all? { |hostname| hostname.type }).to be_truthy
    end

    it "should parse the name" do
      expect(subject.all? { |hostname| hostname.name }).to be_truthy
    end

    it "should include a user hostname" do
      expect(subject.any? { |hostname| hostname.type == 'user' }).to be_truthy
    end

    it "should include a PTR hostname" do
      expect(subject.any? { |hostname| hostname.type == 'PTR' }).to be_truthy
    end
  end

  describe "#hostname" do
    it "should return the first hostname" do
      expect(subject.hostname).to be == subject.hostnames.first
    end
  end

  describe "#os" do
    subject { super().os }

    it { is_expected.not_to be_nil }
    it { is_expected.to be_kind_of(OS) }
  end

  describe "#ports" do
    subject { super().ports }

    it { is_expected.not_to be_empty }
  end

  describe "#open_ports" do
    subject { super().open_ports }

    it { is_expected.not_to be_empty }

    it "should list the open ports" do
      expect(subject.all? { |port| port.state == :open }).to be_truthy
    end
  end

  describe "#tcp_ports" do
    subject { super().tcp_ports }

    it { is_expected.not_to be_empty }

    it "should contain TCP ports" do
      expect(subject.all? { |port| port.protocol == :tcp }).to be_truthy
    end
  end

  describe "#udp_ports" do
    subject { super().udp_ports }

    it { is_expected.not_to be_empty }

    it "should contain UDP ports" do
      expect(subject.all? { |port| port.protocol == :udp }).to be_truthy
    end
  end

  describe "#to_s" do
    it "should return the first hostname" do
      expect(subject.to_s).to eq('scanme.nmap.org')
    end

    context "when #hostname returns nil" do
      before { expect(subject).to receive(:hostname).and_return(nil) }

      it "should return the first address" do
        expect(subject.to_s).to eq(ipv4)
      end
    end
  end

  describe "#inspect" do
    it "should include the String representation of the host" do
      expect(subject.inspect).to include(subject.to_s)
    end
  end

  describe "#host_script" do
    subject { super().host_script }

    pending "scan.xml does not currently include any hostscript elements"
  end

  describe "#vendor" do
    subject { @local_xml.host }

    it "should parse the vendor name" do
      expect(subject.vendor).to eq('LG Electronics')
    end 
  end
end
