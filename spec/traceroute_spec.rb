require 'spec_helper'
require 'nmap/traceroute'

describe Traceroute do
  subject { @xml.hosts.first.traceroute }

  describe "#port" do
    subject { super().port }

    it { is_expected.to be_kind_of(Integer) }
    it { is_expected.to be > 0 }
    it { is_expected.to be < 65535 }
  end

  describe "#protocol" do
    subject { super().protocol }

    it { is_expected.to be_kind_of(Symbol) }
    it { is_expected.to eq(:tcp).or eq(:udp) }
  end

  describe "#each" do
    subject { super().each.first }

    it { is_expected.to be_kind_of(Hop) }

    describe '#addr' do
      subject { super().addr }
      it { is_expected.to be_kind_of(String)  }
    end

    describe '#ttl' do
      subject { super().ttl }
      it { is_expected.to be_kind_of(String)  }
    end

    describe '#rtt' do
      subject { super().rtt }
      it { is_expected.to be_kind_of(String)  }
    end
  end
end
