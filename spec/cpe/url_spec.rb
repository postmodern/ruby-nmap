require 'spec_helper'

describe CPE::URL do
  describe "parse" do
    context "when the URL does not start with 'cpe:'" do
      it "should raise an ArgumentError" do
        lambda {
          described_class.parse('foo:')
        }.should raise_error(ArgumentError)
      end
    end

    context "when blank fields are omitted" do
      let(:vendor)  { :linux        }
      let(:product) { :linux_kernel }
      let(:version) { '2.6.39'      }

      subject do
        described_class.parse("cpe:/o:#{vendor}:#{product}:#{version}")
      end

      it "should leave them nil" do
        subject.vendor.should == vendor
        subject.product.should == product
        subject.version.should == version

        subject.update.should be_nil
        subject.edition.should be_nil
        subject.language.should be_nil
      end
    end

    context "when part is /h" do
      subject { described_class.parse("cpe:/h:foo:bar:baz") }

      it "should parse it as :hardware" do
        subject.part.should == :hardware
      end
    end

    context "when part is /a" do
      subject { described_class.parse("cpe:/a:foo:bar:baz") }

      it "should parse it as :application" do
        subject.part.should == :application
      end
    end

    context "when part is /o" do
      subject { described_class.parse("cpe:/o:foo:bar:baz") }

      it "should parse it as :os" do
        subject.part.should == :os
      end
    end
  end

  describe "#to_s" do
    let(:vendor)  { :linux        }
    let(:product) { :linux_kernel }
    let(:version) { '2.6.39'      }

    it "should add the scheme 'cpe:'" do
      subject.to_s.should start_with('cpe:')
    end

    context "when fields are nil" do
      subject { described_class.new(:os,vendor,product,version) }

      it "should omit them" do
        subject.to_s.should == "cpe:/o:#{vendor}:#{product}:#{version}"
      end
    end

    context "when part is :hardware" do
      subject { described_class.new(:hardware) }

      it "should map it to /h" do
        subject.to_s.should == "cpe:/h"
      end
    end

    context "when part is :application" do
      subject { described_class.new(:application) }

      it "should map it to /h" do
        subject.to_s.should == "cpe:/a"
      end
    end

    context "when part is :os" do
      subject { described_class.new(:os) }

      it "should map it to /h" do
        subject.to_s.should == "cpe:/o"
      end
    end
  end
end
