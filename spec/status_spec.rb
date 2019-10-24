require 'spec_helper'
require 'nmap/status'

describe Status do
  describe "#to_s" do
    let(:state)  { :up }
    let(:reason) { 'syn-ack' }
    let(:reason_ttl) { 100 }

    subject { described_class.new(state,reason,reason_ttl) }

    it "should return the state" do
      expect(subject.to_s).to eq(state.to_s)
    end
  end
end
