require 'spec_helper'
require 'nmap/xml'

describe XML do
  subject { XML.new(Helpers::SCAN_FILE) }

  it "should have a version" do
    subject.version.should == '1.02'
  end

  it "should parse the scanner version" do
    subject.scanner.version == '4.68'
  end

  it "should parse the scanner name" do
    subject.scanner.name.should == 'nmap'
  end

  it "should parse the scanner arguments" do
    subject.scanner.arguments.should == 'nmap -v -oX samples/backspace.xml -O -P0 -sS 192.168.5.*'
  end

  it "should parse the scanner start time" do
    subject.scanner.start_time.should == Time.at(1218934249)
  end

  it "should parse the scan information" do
    scan_info = subject.scan_info

    scan_info.length.should == 1
    scan_info.first.type.should == :syn
    scan_info.first.protocol.should == :tcp
  end

  it "should parse the verbose level" do
    subject.verbose.should == 1
  end

  it "should parse the debugging level" do
    subject.debugging.should == 0
  end

  it "should parse the scan tasks" do
    tasks = subject.tasks

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
    subject.hosts.length.should == 10
  end

  it "should iterate over each up host" do
    subject.each.all? { |host| host.status.state == :up }.should == true
  end

  it "should convert to a String" do
    subject.to_s.should == Helpers::SCAN_FILE
  end
end
