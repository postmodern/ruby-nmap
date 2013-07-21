require 'rspec'

shared_examples_for "#scripts" do
  describe "#scripts" do
    subject { super().scripts }

    it { should be_kind_of(Hash) }
    it { should_not be_empty     }
  end
end
