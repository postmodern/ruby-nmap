require 'rspec'

shared_examples_for "CPE" do
  subject { super().cpe }

  it { should_not be_empty }

  it "should contain CPE URLs" do
    subject.should all_be_kind_of(CPE::URL)
  end
end
