require 'spec_helper'
require 'nmap/ip_id_sequence'

describe IpidSequence do
  let(:xml) { XML.new(Helpers::SCAN_FILE) }

  subject { xml.hosts.first.ip_id_sequence }

  it "should be accessible from host objects" do
    subject.should be_kind_of(IpidSequence)
  end

  it "should parse the description" do
    subject.description.should == "Incremental"
  end

  it "should parse the values" do
    subject.values.should == [0x1FB0, 0x1FB2, 0x1FB4, 0x1FB6, 0x1FB8, 0x1FBA]
  end
end
