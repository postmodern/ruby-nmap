require 'spec_helper'
require 'helpers/xml'

require 'nmap/xml'
require 'nmap/port'

describe Port do
  include Helpers

  before(:all) do
    @xml = XML.new(Helpers::SCAN_FILE)
    @nse_xml = XML.new(Helpers::NSE_FILE)

    @port = @xml.hosts.first.ports.first
    @nse_port = @nse_xml.hosts.first.ports.first
  end

  it "should parse the protocol" do
    @port.protocol.should == :tcp
  end

  it "should parse the port number" do
    @port.number.should == 21
  end

  it "should parse the state" do
    @port.state.should == :closed
  end

  it "should parse the reason" do
    @port.reason.should == 'reset'
  end

  it "should parse the detected service" do
    @port.service.should == 'ftp'
  end

  it "should parse the output of NSE scripts ran against the port" do
    @nse_port.scripts.should_not be_empty

    @nse_port.scripts.keys.should_not include(nil)
    @nse_port.scripts.values.should_not include(nil)
  end
end
