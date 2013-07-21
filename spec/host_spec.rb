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

  it "should parse the status" do
    status = subject.status
    
    status.state.should == :up
    %w[timestamp-reply echo-reply reset].should include(status.reason)
  end

  it "should parse the addresses" do
    addresses = subject.addresses
    
    addresses.length.should == 1

    addresses[0].type.should == :ipv4
    addresses[0].addr.should == '74.207.244.221'
  end

  it "should parse the IPv4 address" do
    subject.ipv4.should == '74.207.244.221'
  end

  it "should parse the IPv6 address" do
    pending "generate a Nmap XML scan file including IPv6 addresses"
  end

  it "should have an IP" do
    subject.ip.should == '74.207.244.221'
  end

  it "should have an address" do
    subject.address.should == '74.207.244.221'
  end

  it "should parse the hostnames" do
    pending "generate a Nmap XML scan file including hostnames"
  end

  it "should parse the OS guessing information" do
    subject.os.should_not be_nil
  end

  it "should parse the ports" do
    ports = subject.ports
    
    ports.should_not be_empty
  end

  it "should list the open ports" do
    ports = subject.open_ports
    
    ports.all? { |port| port.state == :open }.should == true
  end

  it "should list TCP ports" do
    ports = subject.tcp_ports
    
    ports.all? { |port| port.protocol == :tcp }.should == true
  end

  it "should list the UDP ports" do
    pending "generate a Nmap XML scan file including scanned UDP ports"
  end

  it "should convert to a String" do
    subject.to_s.should == '74.207.244.221'
  end

  describe "#inspect" do
    it "should include the address" do
      subject.inspect.should include(subject.address)
    end
  end

  include_examples "#scripts"
end
