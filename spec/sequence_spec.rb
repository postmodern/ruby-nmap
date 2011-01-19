require 'spec_helper'
require 'helpers/xml'

require 'nmap/tcpsequence'
require 'nmap/tcptssequence'
require 'nmap/ipidsequence'
require 'nmap/xml'
require 'cgi'


describe TcpSequence do
  include Helpers

  before(:all) do
    @xml = XML.new(Helpers::SCAN_FILE)
    @tcpsequence = @xml.hosts.first.tcpsequence
  end

  it "should be accessible from host objects" do
    @tcpsequence.should be_kind_of(TcpSequence)
  end

  it "should parse the index" do
    @tcpsequence.index.should == 25
  end

  it "should parse the difficulty description" do
    @tcpsequence.difficulty.should == "Good luck!"
  end

  it "should parse the values" do
    @tcpsequence.values.should == [0xAF1B39BD,0xAF1C33BD,0xAF1F21BD,0xAF201BBD,0xAF2115BD,0xAF220FBD]
  end
end

describe IpidSequence do
  include Helpers

  before(:all) do
    @xml = XML.new(Helpers::SCAN_FILE)
    @ipidsequence = @xml.hosts.first.ipidsequence
  end

  it "should be accessible from host objects" do
    @ipidsequence.should be_kind_of(IpidSequence)
  end

  it "should parse the description" do
    @ipidsequence.description.should == "Incremental"
  end

  it "should parse the values" do
    @ipidsequence.values.should == [0x1FB0,0x1FB2,0x1FB4,0x1FB6,0x1FB8,0x1FBA]
  end
end

describe TcpTsSequence do
  include Helpers

  before(:all) do
    @xml = XML.new(Helpers::SCAN_FILE)
    @tcptssequence = @xml.hosts.first.tcptssequence
  end

  it "should be accessible from host objects" do
    @tcptssequence.should be_kind_of(TcpTsSequence)
  end

  it "should parse the description" do
    @tcptssequence.description.should == "2HZ"
  end

  it "should parse the values" do
    @tcptssequence.values.should == [0x1858,0x1858,0x1859,0x1859,0x1859,0x1859]
  end

end

