require 'nmap/xml'

require 'spec_helper'
require 'helpers/xml'

describe XML do
  include Helpers

  before(:all) do
    @xml = XML.new(Helpers::SCAN_FILE)
  end

  it "should have a version" do
    @xml.version.should == '1.02'
  end

  it "should parse the scanner version" do
    @xml.scanner.version == '4.68'
  end

  it "should parse the scanner name" do
    @xml.scanner.name.should == 'nmap'
  end

  it "should parse the scanner arguments" do
    @xml.scanner.arguments.should == 'nmap -v -oX samples/backspace.xml -O -P0 -sS 192.168.5.*'
  end

  it "should parse the scanner start time" do
    @xml.scanner.start_time.should == Time.at(1218934249)
  end

  it "should parse the scan information" do
    scan_info = @xml.scan_info

    scan_info.length.should == 1
    scan_info.first.type.should == :syn
    scan_info.first.protocol.should == :tcp
  end

  it "should parse the verbose level" do
    @xml.verbose.should == 1
  end

  it "should parse the debugging level" do
    @xml.debugging.should == 0
  end

  it "should parse the scan tasks" do
    tasks = @xml.tasks

    tasks.should_not be_empty

    tasks.each do |task|
      task.name.should_not be_nil
      task.name.should_not be_empty

      task.start_time.should > Time.at(0)

      task.end_time.should > Time.at(0)
      task.end_time.should >= task.start_time
    end
  end

  it "should parse the hosts" do
    @xml.hosts.length.should == 10
  end

  it "should convert to a String" do
    @xml.to_s.should == Helpers::SCAN_FILE
  end
end
