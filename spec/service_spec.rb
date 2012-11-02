require 'spec_helper'
require 'helpers/xml'

require 'nmap/xml'
require 'nmap/service'

describe Service do
  include Helpers

  before(:all) do
    @xml = XML.new(Helpers::SCAN_FILE)
    @nse_xml = XML.new(Helpers::NSE_FILE)
  end

  subject { @xml.hosts.first.ports.first.service }

  it "should have a name" do
    subject.name.should == 'ftp'
  end

  it "should have a fingerprint method" do
    subject.fingerprint_method.should == :table
  end

  it "should have a confidence" do
    subject.confidence.should == 3
  end

  context "with improved detection" do
    subject { @nse_xml.hosts.first.ports.first.service }

    it "should have a product name" do
      subject.product.should == 'OpenSSH'
    end

    it "should have a version" do
      subject.version.should == '5.1p1 Debian 6ubuntu2'
    end
  end
end
