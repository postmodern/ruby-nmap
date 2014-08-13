require 'spec_helper'

shared_examples_for "Sequence" do
  describe "#values" do
    subject { super().values }

    it 'has 6 items' do
      expect(subject.size).to eq(6)
    end
    it { is_expected.to all(be_between(0,0xFFFFFFFF)) }
  end
end
