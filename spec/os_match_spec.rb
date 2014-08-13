require 'spec_helper'
require 'nmap/os_match'

describe OSMatch do
  describe "#to_s" do
    let(:name)     { 'Linux 2.6.39' }
    let(:accuracy) { 97             }

    subject { described_class.new(name,accuracy) }

    it "should include the name and accuracy" do
      expect(subject.to_s).to eq("#{name} (#{accuracy}%)")
    end
  end
end
