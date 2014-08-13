require 'rspec'

shared_examples_for "#scripts" do
  describe "#scripts" do
    subject { super().scripts }

    it { is_expected.to be_kind_of(Hash) }
    it { is_expected.not_to be_empty     }
  end
end
