require 'spec_helper'
require 'nmap/xml'

describe XML do
  let(:path) { File.expand_path('spec/scan.xml') }

  subject { described_class.new(path) }

  it "should have a version" do
    subject.version.should == '1.04'
  end

  it "should parse the scanner version" do
    subject.scanner.version == '4.68'
  end

  it "should parse the scanner name" do
    subject.scanner.name.should == 'nmap'
  end

  it "should parse the scanner arguments" do
    subject.scanner.arguments.should == 'nmap -v -sS -A -O -oX spec/scan.xml scanme.nmap.org'
  end

  it "should parse the scanner start time" do
    subject.scanner.start_time.should be_kind_of(Time)
  end

  describe "#scan_info" do
    subject { super().scan_info.first }

    it "should parse the type" do
      subject.type.should == :syn
    end

    it "should parse the protocol" do
      subject.protocol.should == :tcp
    end

    it "should parse the services" do
      subject.services.should_not be_empty
    end
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

  describe "#hosts" do
    subject { super().hosts }

    it { should_not be_empty }

    it "should contain Host objects" do
      subject.all? { |host| host.kind_of?(Host) }.should be_true
    end
  end

  it "should iterate over each up host" do
    subject.each.all? { |host| host.status.state == :up }.should == true
  end

  it "should convert to a String" do
    subject.to_s.should == path
  end
end
