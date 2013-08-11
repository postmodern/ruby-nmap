require 'spec_helper'
require 'nmap/xml'

describe XML do
  let(:path) { File.expand_path('spec/scan.xml') }

  subject { described_class.new(path) }

  describe "load" do
    it "should parse the given text" do
      subject.version.should == described_class.load(File.read(path)).version
    end
  end

  describe "open" do
    it "should parse the given file" do
      subject.version.should == described_class.open(path).version
    end
  end

  describe "#version" do
    it "should have a version" do
      subject.version.should == '1.04'
    end
  end

  describe "#scanner" do
    it "should parse the scanner version" do
      subject.scanner.version == '4.68'
    end

    it "should parse the scanner name" do
      subject.scanner.name.should == 'nmap'
    end

    it "should parse the scanner arguments" do
      subject.scanner.arguments.should == 'nmap -v -sS -sU -A -O -oX spec/scan.xml scanme.nmap.org'
    end

    it "should parse the scanner start time" do
      subject.scanner.start_time.should be_kind_of(Time)
    end
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

  describe "#each_run_stat" do
    subject { super().each_run_stat.first }

    it "should yield RunStat objects" do
      subject.should be_kind_of(RunStat)
    end

    it "should parse the end time" do
      subject.end_time.should be_kind_of(Time)
    end

    it "should parse the time elapsed" do
      subject.elapsed.should_not be_nil
    end

    it "should parse the summary" do
      subject.summary.should_not be_empty
    end

    it "should parse the exit status" do
      subject.exit_status.should be_one_of('success', 'failure')
    end
  end

  describe "#run_stats" do
    subject { super().run_stats }

    it { should_not be_empty }
    it { should all_be_kind_of(RunStat) }
  end

  describe "#each_task" do
    subject { super().each_task.first }

    it "should parse task name" do
      subject.name.should == 'Ping Scan'
    end

    it "should parse the start time" do
      subject.start_time.should be_kind_of(Time)
    end

    it "should parse the end time" do
      subject.end_time.should be_kind_of(Time)
      subject.end_time.should > subject.start_time
    end

    it "should parse the extrainfo" do
      subject.extrainfo.should_not be_empty
    end
  end

  describe "#tasks" do
    subject { super().tasks }

    it { should_not be_empty }
    it { should all_be_kind_of(ScanTask) }
  end

  describe "#each_host" do
    subject { super().each_host.first }

    it "should yield Host objects" do
      subject.should be_kind_of(Host)
    end
  end

  describe "#hosts" do
    subject { super().hosts }

    it { should_not be_empty }
    it { subject.should all_be_kind_of(Host) }
  end

  describe "#each_up_host" do
    subject { super().each_up_host.first }

    it "should yield Host objects" do
      subject.should be_kind_of(Host)
    end

    it "should be up" do
      subject.status.state.should be == :up
    end
  end

  describe "#up_hosts" do
    subject { super().up_hosts }

    it { should_not be_empty }
    it { should all_be_kind_of(Host) }

    it "should contain only up hosts" do
      subject.all? { |host| host.status.state == :up }.should be_true
    end
  end

  describe "#each" do
    it "should iterate over each up host" do
      subject.each.all? { |host| host.status.state == :up }.should == true
    end
  end

  describe "#to_s" do
    it "should convert to a String" do
      subject.to_s.should == path
    end
  end

  describe "#inspect" do
    it "should include the class and path" do
      subject.inspect.should == "#<#{described_class}: #{path}>"
    end
  end
end
