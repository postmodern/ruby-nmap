require 'rspec'

shared_examples_for "#scripts" do
  describe "#scripts" do
    subject { super().scripts }

    it { is_expected.to be_kind_of(Hash) }
    it { is_expected.not_to be_empty     }

    it "should contain String keys" do
      expect(subject.keys).to all(be_kind_of(String))
    end
    
    it "should contain String values" do
      expect(subject.values).to all(be_kind_of(String))
    end
  end
end

shared_examples_for "#script_data" do
  describe "#script_data" do
    subject { super().script_data }

    it { is_expected.to be_kind_of(Hash) }
    it { is_expected.not_to be_empty     }

    it "should contain String keys" do
      expect(subject.keys).to all(be_kind_of(String))
    end

    it "should contain Hash values" do
      expect(subject.values).to all(be_kind_of(Hash))
    end

    it "should the Hash values should contain String keys" do
      expect(subject.values.map(&:keys).flatten).to all(be_kind_of(String))
    end

    it "should the Hash values should contain Array<String> values" do
      expect(subject.values.map(&:values).flatten).to all(be_kind_of(String))
    end
  end
end
