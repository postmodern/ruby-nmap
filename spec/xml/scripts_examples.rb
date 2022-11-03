require 'rspec'
require 'nmap/xml/script'

shared_examples_for "#scripts" do
  describe "#scripts" do
    subject { super().scripts }

    it { is_expected.to be_kind_of(Hash) }
    it { is_expected.not_to be_empty     }

    it "should contain String keys" do
      expect(subject.keys).to all(be_kind_of(String))
    end
    
    it "should contain Nmap::XML::Script values" do
      expect(subject.values).to all(be_kind_of(Nmap::XML::Script))
    end
  end
end
