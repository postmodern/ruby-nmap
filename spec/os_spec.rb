require 'spec_helper'

require 'nmap/os'
require 'cgi'

describe OS do
  subject { @xml.hosts.first.os }

  describe "#classes" do
    subject { super().classes }

    it { is_expected.not_to be_empty }

    it "should return OSClass objects" do
      expect(subject).to all(be_kind_of(OSClass))
    end
  end

  describe "#matches" do
    subject { super().matches.first }

    it "should parse the name" do
      expect(subject.name).to eq('Linux 3.0')
    end

    it "should parse the accuracy" do
      expect(subject.accuracy).to be_between(0,100)
    end
  end

  describe "#ports_used" do
    subject { super().ports_used }

    it { expect(subject).not_to be_empty }
    it { expect(subject).to all(be_between(0,65535)) }
  end

  describe "#fingerprint" do
    it "should parse the OS fingerprints" do
      pending "scan.xml does not currently have an osfingerprint"
      expect(subject.fingerprint).to eq(CGI.unescapeHTML("SCAN(V=4.68%D=8/16%OT=443%CT=21%CU=%PV=Y%DS=1%G=N%M=001D7E%TM=48A77607%P=i686-pc-linux-gnu)&#xa;SEQ(SP=19%GCD=FA00%ISR=9E%TI=I%TS=1)&#xa;OPS(O1=M5B4NW0NNT11%O2=M5B4NW0NNT11%O3=M5B4NW0NNT11%O4=M5B4NW0NNT11%O5=M5B4NW0NNT11%O6=M5B4NNT11)&#xa;WIN(W1=2000%W2=2000%W3=2000%W4=2000%W5=2000%W6=2000)&#xa;ECN(R=Y%DF=N%TG=40%W=2000%O=M5B4NW0%CC=N%Q=)&#xa;T1(R=Y%DF=N%TG=40%S=O%A=S+%F=AS%RD=0%Q=)&#xa;T2(R=N)&#xa;T3(R=N)&#xa;T4(R=N)&#xa;T5(R=Y%DF=N%TG=40%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)&#xa;T6(R=N)&#xa;T7(R=N)&#xa;U1(R=N)&#xa;IE(R=N)&#xa;"))
    end
  end
end
