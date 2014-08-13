require 'spec_helper'
require 'nmap/scanner'

describe Scanner do
  describe "#to_s" do
    let(:name)    { 'nmap' }
    let(:version) { '6.01' }
    let(:args)    { 'nmap -v -sS -sU -A -O -oX spec/scan.xml scanme.nmap.org' }
    let(:start_time) { Time.new('Sat Jul 20 23:55:27 2013') }

    subject do
      described_class.new(
        name,
        version,
        args,
        start_time
      )
    end

    it "should return the scanner command" do
      expect(subject.to_s).to eq("#{name} #{args}")
    end
  end
end
