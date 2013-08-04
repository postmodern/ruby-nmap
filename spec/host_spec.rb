require 'spec_helper'
require 'scripts_examples'

require 'nmap/xml'
require 'nmap/host'

describe Host do
  subject { @xml.hosts.first }

  it "should parse the start_time" do
    subject.start_time.should > Time.at(0)
  end

  it "should parse the end_time" do
    subject.end_time.should > Time.at(0)
    subject.end_time.should > subject.start_time
  end

  describe "#uptime" do
    subject { super().uptime }

    it "should return an Uptime object" do
      subject.should be_kind_of(Uptime)
    end

    it "should parse the seconds attribute" do
      subject.seconds.should be > 0
    end

    it "should parse the lastboot attribute" do
      subject.lastboot.should be_kind_of(Time)
    end
  end

  describe "#tcp_sequence" do
    subject { super().tcp_sequence }

    it { should be_kind_of(TcpSequence) }
  end

  describe "#ip_ip_sequence" do
    subject { super().ip_id_sequence }

    it { should be_kind_of(IpIdSequence) }
  end

  describe "#tcp_ts_sequence" do
    subject { super().tcp_ts_sequence }

    it { should be_kind_of(TcpTsSequence) }
  end

  describe "#status" do
    subject { super().status }

    it "should parse the state" do
      subject.state.should be_one_of(:up, :down)
    end

    it "should parse the reason" do
      subject.reason.should be_one_of(
        'syn-ack',
        'timestamp-reply',
        'echo-reply',
        'reset'
      )
    end
  end

  describe "#addresses" do
    subject { super().addresses.first }

    it "should parse the type" do
      subject.type.should == :ipv4
    end

    it "should parser the addr" do
      subject.addr.should == '74.207.244.221'
    end
  end

  describe "#mac" do
    it "should parse the first MAC address" do
      pending "need a host with address[@addrtype='mac']"
    end
  end

  describe "#ipv6" do
    it "should parse the first IPv6 address" do
      pending "need a host with address[@addrtype='ipv6']"
    end
  end

  describe "#ipv4" do
    it "should parse the IPv4 address" do
      subject.ipv4.should == '74.207.244.221'
    end
  end

  describe "#ip" do
    it "should have an IP" do
      subject.ip.should == '74.207.244.221'
    end
  end

  describe "#address" do
    it "should have an address" do
      subject.address.should == '74.207.244.221'
    end
  end

  describe "#hostnames" do
    subject { super().hostnames }

    it { should_not be_empty }

    it "should parse the type" do
      subject.all? { |hostname| hostname.type }.should be_true
    end

    it "should parse the name" do
      subject.all? { |hostname| hostname.name }.should be_true
    end

    it "should include a user hostname" do
      subject.any? { |hostname| hostname.type == 'user' }.should be_true
    end

    it "should include a PTR hostname" do
      subject.any? { |hostname| hostname.type == 'PTR' }.should be_true
    end
  end

  describe "#os" do
    subject { super().os }

    it { should_not be_nil }
    it { should be_kind_of(OS) }
  end

  describe "#ports" do
    subject { super().ports }

    it { should_not be_empty }
  end

  describe "#open_ports" do
    subject { super().open_ports }

    it { should_not be_empty }

    it "should list the open ports" do
      subject.all? { |port| port.state == :open }.should be_true
    end
  end

  describe "#tcp_ports" do
    subject { super().tcp_ports }

    it { should_not be_empty }

    it "should contain TCP ports" do
      subject.all? { |port| port.protocol == :tcp }.should be_true
    end
  end

  describe "#udp_ports" do
    subject { super().udp_ports }

    it { should_not be_empty }

    it "should contain UDP ports" do
      subject.all? { |port| port.protocol == :udp }.should be_true
    end
  end

  it "should convert to a String" do
    subject.to_s.should == '74.207.244.221'
  end

  describe "#inspect" do
    it "should include the address" do
      subject.inspect.should include(subject.address)
    end
  end

  pending "scan.xml does not currently include any hostscripts" do
    include_examples "#scripts"
  end
end
