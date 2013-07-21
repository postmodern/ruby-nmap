require 'spec_helper'

shared_examples_for "Sequence" do
  describe "#values" do
    subject { super().values }

    it "should have length of 6" do
      subject.length.should == 6
    end

    it { should all_be_between(0,0xFFFFFFFF) }
  end
end
