require 'spec_helper'
require 'helpers/xml'

require 'nmap/xml'
require 'nmap/host'

describe Host do
  include Helpers

  before(:all) do
    @xml = XML.new(Helpers::SCAN_FILE)
    @host = @xml.hosts.first
  end

  it "should parse the start_time" do
    @host.start_time.should > Time.at(0)
  end

  it "should parse the end_time" do
    @host.end_time.should > Time.at(0)
    @host.end_time.should > @host.start_time
  end

  it "should parse the status" do
    status = @host.status
    
    status.state.should == :up
    status.reason.should == 'arp-response'
  end

  it "should parse the addresses" do
    addresses = @host.addresses
    
    addresses.length.should == 2

    addresses[0].type.should == :ipv4
    addresses[0].addr.should == '192.168.5.1'

    addresses[1].type.should == :mac
    addresses[1].addr.should == '00:1D:7E:EF:2A:E5'
  end

  it "should parse the MAC address" do
    @host.mac.should == '00:1D:7E:EF:2A:E5'
  end

  it "should parse the IPv4 address" do
    @host.ipv4.should == '192.168.5.1'
  end

  it "should parse the IPv6 address" do
    pending "generate a Nmap XML scan file including IPv6 addresses"
  end

  it "should have an IP" do
    @host.ip.should == '192.168.5.1'
  end

  it "should have an address" do
    @host.address.should == '192.168.5.1'
  end

  it "should parse the hostnames" do
    pending "generate a Nmap XML scan file including hostnames"
  end

  it "should parse the OS guessing information" do
    @host.os.should_not be_nil
  end

  it "should parse the ports" do
    ports = @host.ports
    
    ports.length.should == 3
    ports[0].protocol.should == :tcp
    ports[0].number.should == 21
    ports[0].state.should == :closed
    ports[0].reason.should == 'reset'
    ports[0].service.should == 'ftp'

    ports[1].protocol.should == :tcp
    ports[1].number.should == 23
    ports[1].state.should == :closed
    ports[1].reason.should == 'reset'
    ports[1].service.should == 'telnet'

    ports[2].protocol.should == :tcp
    ports[2].number.should == 443
    ports[2].state.should == :open
    ports[2].reason.should == 'syn-ack'
    ports[2].service.should == 'https'
  end

  it "should list the open ports" do
    ports = @host.open_ports
    
    ports.length.should == 1
    ports.all? { |port| port.state == :open }.should == true
  end

  it "should list TCP ports" do
    ports = @host.tcp_ports
    
    ports.length.should == 3
    ports.all? { |port| port.protocol == :tcp }.should == true
  end

  it "should list the UDP ports" do
    pending "generate a Nmap XML scan file including scanned UDP ports"
  end

  it "should convert to a String" do
    @host.to_s.should == '192.168.5.1'
  end
end
