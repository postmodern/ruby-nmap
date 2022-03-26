require 'rspec'

shared_examples_for "CPE" do
  subject { super().cpe }

  it { is_expected.not_to be_empty }

  it "should contain CPE URLs" do
    expect(subject).to all(be_kind_of(Nmap::XML::CPE::URL))
  end
end
