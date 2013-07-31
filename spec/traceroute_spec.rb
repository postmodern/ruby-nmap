require 'spec_helper'
require 'nmap/traceroute'

describe Traceroute do
  subject { @xml.hosts.first.traceroute }

  describe "#port" do
    subject { super().port }

    it { should be_kind_of(Integer) }
    it { should be > 0 }
    it { should be < 65535 }
  end

  describe "#protocol" do
    subject { super().protocol }

    it { should be_kind_of(Symbol) }
    it { should be_one_of(:tcp, :udp) }
  end

  describe "#each" do
    subject { super().each }

    it { should all_be_kind_of(Hop) }
  end
end
