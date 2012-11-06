require 'spec_helper'

require 'nmap/xml'
require 'nmap/host'

describe Host do
  let(:xml) { XML.new(Helpers::SCAN_FILE) }

  subject { xml.hosts.first }

  it "should parse the start_time" do
    subject.start_time.should > Time.at(0)
  end

  it "should parse the end_time" do
    subject.end_time.should > Time.at(0)
    subject.end_time.should > subject.start_time
  end

  it "should parse the status" do
    status = subject.status
    
    status.state.should == :up
    status.reason.should == 'arp-response'
  end

  it "should parse the addresses" do
    addresses = subject.addresses
    
    addresses.length.should == 2

    addresses[0].type.should == :ipv4
    addresses[0].addr.should == '192.168.5.1'

    addresses[1].type.should == :mac
    addresses[1].addr.should == '00:1D:7E:EF:2A:E5'
  end

  it "should parse the MAC address" do
    subject.mac.should == '00:1D:7E:EF:2A:E5'
  end

  it "should parse the IPv4 address" do
    subject.ipv4.should == '192.168.5.1'
  end

  it "should parse the IPv6 address" do
    pending "generate a Nmap XML scan file including IPv6 addresses"
  end

  it "should have an IP" do
    subject.ip.should == '192.168.5.1'
  end

  it "should have an address" do
    subject.address.should == '192.168.5.1'
  end

  it "should parse the hostnames" do
    pending "generate a Nmap XML scan file including hostnames"
  end

  it "should parse the OS guessing information" do
    subject.os.should_not be_nil
  end

  it "should parse the ports" do
    ports = subject.ports
    
    ports.length.should == 3
  end

  it "should list the open ports" do
    ports = subject.open_ports
    
    ports.length.should == 1
    ports.all? { |port| port.state == :open }.should == true
  end

  it "should list TCP ports" do
    ports = subject.tcp_ports
    
    ports.length.should == 3
    ports.all? { |port| port.protocol == :tcp }.should == true
  end

  it "should list the UDP ports" do
    pending "generate a Nmap XML scan file including scanned UDP ports"
  end

  it "should convert to a String" do
    subject.to_s.should == '192.168.5.1'
  end

  context "when NSE scripts are ran" do
    let(:xml) { XML.new(Helpers::NSE_FILE) }

    subject { xml.hosts.first }

    it "should list output of the scripts" do
      subject.scripts.should_not be_empty

      subject.scripts.keys.should_not include(nil)
      subject.scripts.values.should_not include(nil)
    end
  end
end
