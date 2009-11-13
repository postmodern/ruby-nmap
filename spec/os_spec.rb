require 'nmap/os'
require 'nmap/xml'
require 'cgi'

require 'spec_helper'
require 'helpers/xml'

describe OS do
  include Helpers

  before(:all) do
    @xml = XML.new(Helpers::SCAN_FILE)
    @os = @xml.hosts.first.os
  end

  it "should parse the OS classes" do
    classes = @os.classes

    classes.length.should == 1
    classes[0].type.should == :WAP
    classes[0].vendor.should == 'Netgear'
    classes[0].family.should == :embedded
    classes[0].accuracy.should == 100
  end

  it "should parse the OS matches" do
    matches = @os.matches

    matches.length.should == 2

    matches[0].name.should == 'Netgear WGR614v6 wireless broadband router'
    matches[0].accuracy.should == 100

    matches[1].name.should == 'Netgear WGR614v7 or WPN824v2 wireless broadband router'
    matches[1].accuracy.should == 100
  end

  it "should parse the ports used" do
    @os.ports_used.should == [443, 21]
  end

  it "should parse the OS fingerprints" do
    @os.fingerprint.should == CGI.unescapeHTML("SCAN(V=4.68%D=8/16%OT=443%CT=21%CU=%PV=Y%DS=1%G=N%M=001D7E%TM=48A77607%P=i686-pc-linux-gnu)&#xa;SEQ(SP=19%GCD=FA00%ISR=9E%TI=I%TS=1)&#xa;OPS(O1=M5B4NW0NNT11%O2=M5B4NW0NNT11%O3=M5B4NW0NNT11%O4=M5B4NW0NNT11%O5=M5B4NW0NNT11%O6=M5B4NNT11)&#xa;WIN(W1=2000%W2=2000%W3=2000%W4=2000%W5=2000%W6=2000)&#xa;ECN(R=Y%DF=N%TG=40%W=2000%O=M5B4NW0%CC=N%Q=)&#xa;T1(R=Y%DF=N%TG=40%S=O%A=S+%F=AS%RD=0%Q=)&#xa;T2(R=N)&#xa;T3(R=N)&#xa;T4(R=N)&#xa;T5(R=Y%DF=N%TG=40%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)&#xa;T6(R=N)&#xa;T7(R=N)&#xa;U1(R=N)&#xa;IE(R=N)&#xa;")
  end
end
