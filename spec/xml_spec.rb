require 'spec_helper'
require 'nmap/xml'

describe XML do
  let(:file) { 'spec/fixtures/scan.xml' }
  let(:path) { File.expand_path(file) }

  subject { described_class.new(path) }

  describe "#initialize" do
    context "when given a Nokogiri::XML::Document" do
      let(:document) { Nokogiri::XML(File.read(path)) }

      it "should use the document" do
        expect(described_class.new(document).version).to eq(subject.version)
      end
    end

    context "when given an IO object" do
      let(:io) { File.new(path) }

      it "should parse the IO object" do
        expect(described_class.new(io).version).to eq(subject.version)
      end
    end

    context "when given a String" do
      it "should parse the file at the path" do
        expect(described_class.new(path).version).to eq(subject.version)
      end
    end
  end

  describe "parse" do
    let(:xml) { File.read(path) }

    subject { described_class.parse(xml) }

    it "should return an XML object" do
      expect(subject).to be_kind_of(described_class)
    end

    it "should parse the XML" do
      expect(subject.version).to_not be_nil
    end
  end

  describe "open" do
    subject { described_class.open(path) }

    it "should return an XML object" do
      expect(subject).to be_kind_of(described_class)
    end

    it "should parse the XML" do
      expect(subject.version).to_not be_nil
    end
  end

  describe "#version" do
    it "should have a version" do
      expect(subject.version).to eq('1.04')
    end
  end

  describe "#scanner" do
    it "should parse the scanner version" do
      subject.scanner.version == '4.68'
    end

    it "should parse the scanner name" do
      expect(subject.scanner.name).to eq('nmap')
    end

    it "should parse the scanner arguments" do
      expect(subject.scanner.arguments).to eq("nmap -v -sS -sU -A -O --script ssh2-enum-algos,ssh-hostkey -oX #{file} scanme.nmap.org")
    end

    it "should parse the scanner start time" do
      expect(subject.scanner.start_time).to be_kind_of(Time)
    end
  end

  describe "#scan_info" do
    subject { super().scan_info.first }

    it "should parse the type" do
      expect(subject.type).to eq(:syn)
    end

    it "should parse the protocol" do
      expect(subject.protocol).to eq(:tcp)
    end

    it "should parse the services" do
      expect(subject.services).not_to be_empty
    end
  end

  it "should parse the verbose level" do
    expect(subject.verbose).to eq(1)
  end

  it "should parse the debugging level" do
    expect(subject.debugging).to eq(0)
  end

  describe "#each_run_stat" do
    subject { super().each_run_stat.first }

    it "should yield RunStat objects" do
      expect(subject).to be_kind_of(RunStat)
    end

    it "should parse the end time" do
      expect(subject.end_time).to be_kind_of(Time)
    end

    it "should parse the time elapsed" do
      expect(subject.elapsed).not_to be_nil
    end

    it "should parse the summary" do
      expect(subject.summary).not_to be_empty
    end

    it "should parse the exit status" do
      expect(subject.exit_status).to eq('success').or eq('failure')
    end
  end

  describe "#run_stats" do
    subject { super().run_stats }

    it { is_expected.not_to be_empty }
    it { is_expected.to all(be_kind_of(RunStat)) }
  end

  describe "#each_task" do
    subject { super().each_task.first }

    it "should parse task name" do
      expect(subject.name).to eq('Ping Scan')
    end

    it "should parse the start time" do
      expect(subject.start_time).to be_kind_of(Time)
    end

    it "should parse the end time" do
      expect(subject.end_time).to be_kind_of(Time)
      expect(subject.end_time).to be >= subject.start_time
    end

    it "should parse the extrainfo" do
      expect(subject.extrainfo).not_to be_empty
    end
  end

  describe "#tasks" do
    subject { super().tasks }

    it { is_expected.not_to be_empty }
    it { is_expected.to all(be_kind_of(ScanTask)) }
  end

  describe "#task" do
    context "when the task with the given name exists" do
      it "must return the matching task" do
        name = "Parallel DNS resolution of 1 host."
        task = subject.task(name)

        expect(task).to be_kind_of(ScanTask)
        expect(task.name).to be == name
      end
    end

    context "when no task with the given name can be found" do
      it "must return nil" do
        expect(subject.task('Foo')).to be(nil)
      end
    end
  end

  describe "#prescript" do
    subject { super().prescript }

    pending "scan.xml does not currently include any prescript elements"
  end

  describe "#postscript" do
    subject { super().postscript }

    pending "scan.xml does not currently include any postscript elements"
  end

  describe "#each_host" do
    subject { super().each_host.first }

    it "should yield Host objects" do
      expect(subject).to be_kind_of(Host)
    end
  end

  describe "#hosts" do
    subject { super().hosts }

    it { is_expected.not_to be_empty }
    it { expect(subject).to all(be_kind_of(Host)) }
  end

  describe "#host" do
    subject { super().host }

    it { expect(subject).to be_kind_of(Host) }
  end

  describe "#down_host" do
    pending "need down hosts in scan.xml" do
      subject { super().down_host }

      it { is_expected.to be_kind_of(Host) }

      it "should contain only up hosts" do
        expect(subject.status.state).to be(:down)
      end
    end
  end

  describe "#each_up_host" do
    subject { super().each_up_host.first }

    it "should yield Host objects" do
      expect(subject).to be_kind_of(Host)
    end

    it "should be up" do
      expect(subject.status.state).to eq(:up)
    end
  end

  describe "#up_hosts" do
    subject { super().up_hosts }

    it { is_expected.not_to be_empty }
    it { is_expected.to all(be_kind_of(Host)) }

    it "should contain only up hosts" do
      expect(subject.all? { |host| host.status.state == :up }).to be_truthy
    end
  end

  describe "#up_host" do
    subject { super().up_host }

    it { is_expected.to be_kind_of(Host) }

    it "should contain only up hosts" do
      expect(subject.status.state).to be(:up)
    end
  end

  describe "#each" do
    it "should iterate over each up host" do
      expect(subject.each.all? { |host| host.status.state == :up }).to eq(true)
    end
  end

  describe "#to_s" do
    it "should convert to a String" do
      expect(subject.to_s).to eq(path)
    end
  end

  describe "#inspect" do
    it "should include the class and path" do
      expect(subject.inspect).to eq("#<#{described_class}: #{path}>")
    end
  end
end
