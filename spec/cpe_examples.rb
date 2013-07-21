require 'rspec'

shared_examples_for "CPE" do
  subject { super().cpe }

  it { should_not be_empty }

  it "should contain CPE URLs" do
    subject.all? { |url| url.kind_of?(CPE::URL) }.should be_true
  end
end
