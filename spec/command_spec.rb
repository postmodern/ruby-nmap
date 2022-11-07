require 'spec_helper'
require 'nmap/command'

describe Nmap::Command do
  describe described_class::Port do
    describe "#validate" do
      context "when given an Integer" do
        let(:value) { 443 }

        it "must return true" do
          expect(subject.validate(value)).to be(true)
        end

        context "but it's less than 1" do
          let(:value) { 0 }

          it "must return [false, \"(...) not within the range of acceptable values (1..65535)\"]" do
            expect(subject.validate(value)).to eq(
              [false, "(#{value.inspect}) not within the range of acceptable values (1..65535)"]
            )
          end
        end

        context "but it's greater than 65535" do
          let(:value) { 65536 }

          it "must return [false, \"(...) not within the range of acceptable values (1..65535)\"]" do
            expect(subject.validate(value)).to eq(
              [false, "(#{value.inspect}) not within the range of acceptable values (1..65535)"]
            )
          end
        end
      end

      context "when given a String" do
        context "and it's a number" do
          let(:value) { '443' }

          it "must return true" do
            expect(subject.validate(value)).to be(true)
          end

          context "but it's less than 1" do
            let(:value) { '0' }

            it "must return [false, \"(...) not within the range of acceptable values (1..65535)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "(#{value.inspect}) not within the range of acceptable values (1..65535)"]
              )
            end
          end

          context "but it's greater than 65535" do
            let(:value) { '65536' }

            it "must return [false, \"(...) not within the range of acceptable values (1..65535)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "(#{value.inspect}) not within the range of acceptable values (1..65535)"]
              )
            end
          end
        end

        context "and it's a service name" do
          let(:value) { "http" }

          it "must return true" do
            expect(subject.validate(value)).to be(true)
          end

          context "and it ends with a '*' character" do
            let(:value) { "http*" }

            it "must return true" do
              expect(subject.validate(value)).to be(true)
            end
          end

          context "and it contains uppercase letters" do
            let(:value) { "XmlIpcRegSvc" }

            it "must return true" do
              expect(subject.validate(value)).to be(true)
            end
          end

          context "and it starts with digits" do
            let(:value) { "1ci-smcs" }

            it "must return true" do
              expect(subject.validate(value)).to be(true)
            end
          end

          context "and it contains digits" do
            let(:value) { "neo4j" }

            it "must return true" do
              expect(subject.validate(value)).to be(true)
            end
          end

          context "and it contains a '-' character" do
            let(:value) { "3gpp-cbsp" }

            it "must return true" do
              expect(subject.validate(value)).to be(true)
            end
          end

          context "but it starts with a '-' character" do
            let(:value) { "-foo" }

            it "must return [false, \"must be a port number or service name (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "must be a port number or service name (#{value.inspect})"]
              )
            end
          end

          context "but it ends with a '-' character" do
            let(:value) { "foo-" }

            it "must return [false, \"must be a port number or service name (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "must be a port number or service name (#{value.inspect})"]
              )
            end
          end

          context "and it contains a '_' character" do
            let(:value) { "kerberos_master" }

            it "must return true" do
              expect(subject.validate(value)).to be(true)
            end
          end

          context "but it starts with a '_' character" do
            let(:value) { "_foo" }

            it "must return [false, \"must be a port number or service name (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "must be a port number or service name (#{value.inspect})"]
              )
            end
          end

          context "but it ends with a '_' character" do
            let(:value) { "foo_" }

            it "must return [false, \"must be a port number or service name (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "must be a port number or service name (#{value.inspect})"]
              )
            end
          end

          context "and it contain's a '/' character" do
            let(:value) { "cl/1" }

            it "must return true" do
              expect(subject.validate(value)).to be(true)
            end
          end

          context "but it starts with a '/' character" do
            let(:value) { "/foo" }

            it "must return [false, \"must be a port number or service name (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "must be a port number or service name (#{value.inspect})"]
              )
            end
          end

          context "but it starts with a '/' character" do
            let(:value) { "foo/" }

            it "must return [false, \"must be a port number or service name (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "must be a port number or service name (#{value.inspect})"]
              )
            end
          end
        end
      end
    end
  end

  describe described_class::PortRange do
    describe "#validate" do
      context "when given an Integer value" do
      end

      context "when given a String value" do
      end

      context "when given a Range of port numbers" do
        let(:value) { (1..1024) }

        it "must return true" do
          expect(subject.validate(value)).to be(true)
        end
      end
    end

    describe "#format" do
      context "when given a single port number" do
        let(:value) { 443 }

        it "must return the formatted port number" do
          expect(subject.format(value)).to eq(value.to_s)
        end
      end

      context "when given a Range of port numbers" do
        let(:value) { 1..1024 }

        it "must return the formatted port number range (ex: 1-102)" do
          expect(subject.format(value)).to eq("#{value.begin}-#{value.end}")
        end
      end
    end
  end

  describe described_class::PortRangeList do
    describe "#validate" do
      context "when given a single port number" do
        let(:value) { 443 }

        it "must return true" do
          expect(subject.validate(value)).to be(true)
        end
      end

      context "when given a Range of port numbers" do
        let(:value) { (1..1024) }

        it "must return true" do
          expect(subject.validate(value)).to be(true)
        end
      end

      context "when given an Array of port numbers" do
        let(:value) { [80, 443] }

        it "must return true" do
          expect(subject.validate(value)).to be(true)
        end

        context "but the Array is empty" do
          let(:value) { [] }

          it "must return [false, \"cannot be empty\"]" do
            expect(subject.validate(value)).to eq(
              [false, "cannot be empty"]
            )
          end
        end

        context "and the Array contains Ranges" do
          let(:value) { [80, (1..42), 443] }

          it "must return true" do
            expect(subject.validate(value)).to be(true)
          end
        end
      end

      context "when given a Hash of protocols and port numbers" do
        let(:value) do
          {tcp: [1,2,3,4], udp: [1,2,3,4], sctp: [1,2,3,4]}
        end

        it "must return true" do
          expect(subject.validate(value)).to be(true)
        end

        context "but the Hash is empty" do
          let(:value) { {} }

          it "must return [false, \"cannot be empty\"]" do
            expect(subject.validate(value)).to eq(
              [false, "cannot be empty"]
            )
          end
        end

        context "but one of the keys is not a known protocol" do
          let(:protocol) { :foo }
          let(:value) do
            {tcp: [1,2,3,4], protocol => [1,2,3,4]}
          end

          it "must return [false, \"unknown protocol (...) must be :tcp, :udp, :sctp\"]" do
            expect(subject.validate(value)).to eq(
              [false, "unknown protocol (#{protocol.inspect}) must be :tcp, :udp, or :sctp"]
            )
          end
        end

        context "but one of the Hash values is not a valid port list class" do
          let(:bad_port_list) { Object.new }
          let(:value) do
            {tcp: [1,2,3,4], udp: bad_port_list, sctp: [1,2,3,4]}
          end

          it "must return [false, \"cannot be converted into an Integer\"]" do
            expect(subject.validate(value)).to eq(
              [false, "element cannot be converted into an Integer (#{bad_port_list.inspect})"]
            )
          end
        end

        context "but one of the elements within the port list is not a port" do
          let(:bad_port) { "" }
          let(:value) do
            {tcp: [1,2,3,4], udp: [1, bad_port, 3], sctp: [1,2,3,4]}
          end

          it "must return [false, \"element not a valid port range (...)\"]" do
            expect(subject.validate(value)).to eq(
              [false, "element not a valid port range (#{bad_port.inspect})"]
            )
          end
        end
      end
    end

    describe "#format" do
      context "when given a single port number" do
        let(:value) { 443 }

        it "must return the formatted port number" do
          expect(subject.format(value)).to eq(value.to_s)
        end
      end

      context "when given a Range of port numbers" do
        let(:value) { (1..1024) }

        it "must return the formatted port number range (ex: 1-102)" do
          expect(subject.format(value)).to eq("#{value.begin}-#{value.end}")
        end
      end

      context "when given an Array of port numbers" do
        let(:value) { [80, 443] }

        it "must return the formatted list of port numbers" do
          expect(subject.format(value)).to eq(value.join(','))
        end

        context "and the Array contains Ranges" do
          let(:value) { [80, (1..42), 443] }

          it "must return the formatted list of port numbers and port ranges" do
            expect(subject.format(value)).to eq("#{value[0]},#{value[1].begin}-#{value[1].end},#{value[2]}")
          end
        end
      end

      context "when given a Hash of protocols and port numbers" do
        let(:value) do
          {tcp: [1,2,3,4], udp: [1,2,3,4], sctp: [1,2,3,4]}
        end

        it "must convert the keys to capital protocol letters and format the values" do
          expect(subject.format(value)).to eq(
            "T:#{subject.format(value[:tcp])},U:#{subject.format(value[:udp])},S:#{subject.format(value[:sctp])}"
          )
        end
      end
    end
  end

  describe described_class::Time do
    describe "#validate" do
      context "when given nil" do
        let(:value) { nil }

        it "must return [false, \"cannot be nil\"]" do
          expect(subject.validate(value)).to eq(
            [false, "cannot be nil"]
          )
        end
      end

      context "when given an Integer" do
        let(:value) { 10 }

        it "must return true" do
          expect(subject.validate(value)).to be(true)
        end
      end

      context "when given a String" do
        context "when given an empty String" do
          let(:value) { "" }

          it "must return [false, \"does not allow an empty value\"]" do
            expect(subject.validate(value)).to eq(
              [false, "does not allow an empty value"]
            )
          end
        end

        context "when given a number" do
          let(:value) { "10" }

          it "must return true" do
            expect(subject.validate(value)).to be(true)
          end
        end

        context "when given a number that ends with 'ms'" do
          let(:value) { "10ms" }

          it "must return true" do
            expect(subject.validate(value)).to be(true)
          end
        end

        context "when given a number that ends with 's'" do
          let(:value) { "10s" }

          it "must return true" do
            expect(subject.validate(value)).to be(true)
          end
        end

        context "when given a number that ends with 'm'" do
          let(:value) { "10m" }

          it "must return true" do
            expect(subject.validate(value)).to be(true)
          end
        end

        context "when given a number that ends with 'h'" do
          let(:value) { "10h" }

          it "must return true" do
            expect(subject.validate(value)).to be(true)
          end
        end

        context "when given a number that ends with an unrecognized unit" do
          let(:value) { "10x" }

          it "must return [false, \"must be a number and end with 'h', 'm', 's', or 'ms'\"]" do
            expect(subject.validate(value)).to eq(
              [false, "must be a number and end with 'h', 'm', 's', or 'ms'"]
            )
          end
        end
      end
    end
  end
end
