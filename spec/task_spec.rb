require 'spec_helper'
require 'nmap/task'

describe Task do
  describe "ports" do
    it "should ignore empty port Arrays" do
      subject.ports = []

      subject.arguments.should == []
    end

    it "should format a String of ports" do
      subject.ports = '80,21,25'

      subject.arguments.should == %w[-p 80,21,25]
    end

    it "should format an Array of String ports" do
      subject.ports = %w[80 21 25]

      subject.arguments.should == %w[-p 80,21,25]
    end

    it "should format an Array of Integer ports" do
      subject.ports = [80, 21, 25]

      subject.arguments.should == %w[-p 80,21,25]
    end

    it "should format a Range of ports" do
      subject.ports = [80, 21..25]

      subject.arguments.should == %w[-p 80,21-25]
    end
  end
end
