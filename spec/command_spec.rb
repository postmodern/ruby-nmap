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

            it "must return [false, \"must be a valid port number or service name (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "must be a valid port number or service name (#{value.inspect})"]
              )
            end
          end

          context "but it's greater than 65535" do
            let(:value) { '65536' }

            it "must return [false, \"must be a valid port number or service name (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "must be a valid port number or service name (#{value.inspect})"]
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

            it "must return  [false, \"must be a valid port number or service name (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "must be a valid port number or service name (#{value.inspect})"]
              )
            end
          end

          context "and it contains digits" do
            let(:value) { "neo4j" }

            it "must return true" do
              expect(subject.validate(value)).to be(true)
            end
          end

          context "and it contains a '-' character" do
            let(:value) { "iphone-sync" }

            it "must return true" do
              expect(subject.validate(value)).to be(true)
            end
          end

          context "but it starts with a '-' character" do
            let(:value) { "-foo" }

            it "must return [false, \"must be a valid port number or service name (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "must be a valid port number or service name (#{value.inspect})"]
              )
            end
          end

          context "but it ends with a '-' character" do
            let(:value) { "foo-" }

            it "must return [false, \"must be a valid port number or service name (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "must be a valid port number or service name (#{value.inspect})"]
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

            it "must return [false, \"must be a valid port number or service name (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "must be a valid port number or service name (#{value.inspect})"]
              )
            end
          end

          context "but it ends with a '_' character" do
            let(:value) { "foo_" }

            it "must return [false, \"must be a valid port number or service name (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "must be a valid port number or service name (#{value.inspect})"]
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

            it "must return [false, \"must be a valid port number or service name (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "must be a valid port number or service name (#{value.inspect})"]
              )
            end
          end

          context "but it ends with a '/' character" do
            let(:value) { "foo/" }

            it "must return [false, \"must be a valid port number or service name (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "must be a valid port number or service name (#{value.inspect})"]
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

      context "when given a String value" do
        context "and it's a number" do
          let(:value) { '443' }

          it "must return true" do
            expect(subject.validate(value)).to be(true)
          end

          context "but it's less than 1" do
            let(:value) { '0' }

            it "must return [false, \"must be a valid port number, port range, or service name (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "must be a valid port number, port range, or service name (#{value.inspect})"]
              )
            end
          end

          context "but it's greater than 65535" do
            let(:value) { '65536' }

            it "must return [false, \"(...) not within the range of acceptable values (1..65535)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "must be a valid port number, port range, or service name (#{value.inspect})"]
              )
            end
          end
        end

        context "and it's a range of two numbers" do
          let(:value) { "1-1024" }

          it "must return true" do
            expect(subject.validate(value)).to be(true)
          end

          context "but the first number is omitted" do
            let(:value) { "-1024" }

            it "must return true" do
              expect(subject.validate(value)).to be(true)
            end
          end

          context "but the last number is omitted" do
            let(:value) { "1-" }

            it "must return true" do
              expect(subject.validate(value)).to be(true)
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

            it "must return  [false, \"must be a valid port number, port range, or service name (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "must be a valid port number, port range, or service name (#{value.inspect})"]
              )
            end
          end

          context "and it contains digits" do
            let(:value) { "neo4j" }

            it "must return true" do
              expect(subject.validate(value)).to be(true)
            end
          end

          context "and it contains a '-' character" do
            let(:value) { "iphone-sync" }

            it "must return true" do
              expect(subject.validate(value)).to be(true)
            end
          end

          context "but it starts with a '-' character" do
            let(:value) { "-foo" }

            it "must return [false, \"must be a valid port number, port range, or service name (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "must be a valid port number, port range, or service name (#{value.inspect})"]
              )
            end
          end

          context "but it ends with a '-' character" do
            let(:value) { "foo-" }

            it "must return [false, \"must be a valid port number, port range, or service name (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "must be a valid port number, port range, or service name (#{value.inspect})"]
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

            it "must return [false, \"must be a valid port number, port range, or service name (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "must be a valid port number, port range, or service name (#{value.inspect})"]
              )
            end
          end

          context "but it ends with a '_' character" do
            let(:value) { "foo_" }

            it "must return [false, \"must be a valid port number, port range, or service name (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "must be a valid port number, port range, or service name (#{value.inspect})"]
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

            it "must return [false, \"must be a valid port number, port range, or service name (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "must be a valid port number, port range, or service name (#{value.inspect})"]
              )
            end
          end

          context "but it starts with a '/' character" do
            let(:value) { "foo/" }

            it "must return [false, \"must be a valid port number, port range, or service name (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "must be a valid port number, port range, or service name (#{value.inspect})"]
              )
            end
          end
        end
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
      context "when given an Integer value" do
        let(:value) { 443 }

        it "must return true" do
          expect(subject.validate(value)).to be(true)
        end

        context "but it's less than 1" do
          let(:value) { 0 }

          it "must return [false, \"element (...) not within the range of acceptable values (1..65535)\"]" do
            expect(subject.validate(value)).to eq(
              [false, "element (#{value.inspect}) not within the range of acceptable values (1..65535)"]
            )
          end
        end

        context "but it's greater than 65535" do
          let(:value) { 65536 }

          it "must return [false, \"element (...) not within the range of acceptable values (1..65535)\"]" do
            expect(subject.validate(value)).to eq(
              [false, "element (#{value.inspect}) not within the range of acceptable values (1..65535)"]
            )
          end
        end
      end

      context "when given a String value" do
        context "and it's a number" do
          let(:value) { '443' }

          it "must return true" do
            expect(subject.validate(value)).to be(true)
          end

          context "but it's less than 1" do
            let(:value) { '0' }

            it "must return [false, \"not a valid port range list (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "not a valid port range list (#{value.inspect})"]
              )
            end
          end

          context "but it's greater than 65535" do
            let(:value) { '65536' }

            it "must return [false, \"(...) not within the range of acceptable values (1..65535)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "not a valid port range list (#{value.inspect})"]
              )
            end
          end
        end

        context "and it's a range of two numbers" do
          let(:value) { "1-1024" }

          it "must return true" do
            expect(subject.validate(value)).to be(true)
          end

          context "but the first number is omitted" do
            let(:value) { "-1024" }

            it "must return true" do
              expect(subject.validate(value)).to be(true)
            end
          end

          context "but the last number is omitted" do
            let(:value) { "1-" }

            it "must return true" do
              expect(subject.validate(value)).to be(true)
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

            it "must return  [false, \"not a valid port range list (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "not a valid port range list (#{value.inspect})"]
              )
            end
          end

          context "and it contains digits" do
            let(:value) { "neo4j" }

            it "must return true" do
              expect(subject.validate(value)).to be(true)
            end
          end

          context "and it contains a '-' character" do
            let(:value) { "iphone-sync" }

            it "must return true" do
              expect(subject.validate(value)).to be(true)
            end
          end

          context "but it starts with a '-' character" do
            let(:value) { "-foo" }

            it "must return [false, \"not a valid port range list (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "not a valid port range list (#{value.inspect})"]
              )
            end
          end

          context "but it ends with a '-' character" do
            let(:value) { "foo-" }

            it "must return [false, \"not a valid port range list (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "not a valid port range list (#{value.inspect})"]
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

            it "must return [false, \"not a valid port range list (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "not a valid port range list (#{value.inspect})"]
              )
            end
          end

          context "but it ends with a '_' character" do
            let(:value) { "foo_" }

            it "must return [false, \"not a valid port range list (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "not a valid port range list (#{value.inspect})"]
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

            it "must return [false, \"not a valid port range list (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "not a valid port range list (#{value.inspect})"]
              )
            end
          end

          context "but it starts with a '/' character" do
            let(:value) { "foo/" }

            it "must return [false, \"not a valid port range list (...)\"]" do
              expect(subject.validate(value)).to eq(
                [false, "not a valid port range list (#{value.inspect})"]
              )
            end
          end
        end

        context "and it's a comma separated list of port numbers" do
          let(:value) { "1,22,80,443" }

          it "must return true" do
            expect(subject.validate(value)).to be(true)
          end
        end

        context "and it's a comma separated list of port ranges" do
          let(:value) { "1-22,8000-9000" }

          it "must return true" do
            expect(subject.validate(value)).to be(true)
          end
        end

        context "and it's a comma separated list of port numbers and ranges" do
          let(:value) { "1-22,80,443,8000-9000" }

          it "must return true" do
            expect(subject.validate(value)).to be(true)
          end
        end

        context "and it's a range of two numbers, with a protocol prefix" do
          let(:value) { "T:1-1024" }

          it "must return true" do
            expect(subject.validate(value)).to be(true)
          end

          context "but the first number is omitted" do
            let(:value) { "T:-1024" }

            it "must return true" do
              expect(subject.validate(value)).to be(true)
            end
          end

          context "but the last number is omitted" do
            let(:value) { "T:1-" }

            it "must return true" do
              expect(subject.validate(value)).to be(true)
            end
          end
        end

        context "and it's a service name, with a protocol prefix" do
          let(:value) { "T:http" }

          it "must return true" do
            expect(subject.validate(value)).to be(true)
          end
        end

        context "and it's a comma separated list of port numbers, with protocol prefixes" do
          let(:value) { "T:1,T:22,T:80,T:443,U:9000" }

          it "must return true" do
            expect(subject.validate(value)).to be(true)
          end
        end

        context "and it's a comma separated list of port ranges, with protocol prefixes" do
          let(:value) { "T:1-22,U:8000-9000" }

          it "must return true" do
            expect(subject.validate(value)).to be(true)
          end
        end

        context "and it's a comma separated list of port numbers and ranges, with protocol prefixes" do
          let(:value) { "T:1-22,T:80,T:443,U:8000-9000" }

          it "must return true" do
            expect(subject.validate(value)).to be(true)
          end
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

          it "must return [false, \"element element must be a valid port number, port range, or service name (...)\"]" do
            expect(subject.validate(value)).to eq(
              [false, "element must be a valid port number, port range, or service name (#{bad_port.inspect})"]
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

          it "must return [false, \"must be a number and end with 'ms', 's', 'm', or 'h'\"]" do
            expect(subject.validate(value)).to eq(
              [false, "must be a number and end with 'ms', 's', 'm', or 'h'"]
            )
          end
        end
      end
    end
  end

  describe described_class::HexString do
    describe "#validate" do
      context "when given nil" do
        let(:value) { nil }

        it "must return [false, \"cannot be nil\"]" do
          expect(subject.validate(value)).to eq(
            [false, "cannot be nil"]
          )
        end
      end

      context "when given a String" do
        context "but it's empty" do
          let(:value) { '' }

          it "must return [false, \"does not allow an empty value\"]" do
            expect(subject.validate(value)).to eq(
              [false, "does not allow an empty value"]
            )
          end
        end

        context "and it's of the format 0xAABBCCDDEEFF" do
          let(:value) { "0xAABBCCDDEEFF" }

          it "must return true" do
            expect(subject.validate(value)).to be(true)
          end
        end

        context "and it's of the format AABBCCDDEEFF" do
          let(:value) { "AABBCCDDEEFF" }

          it "must return true" do
            expect(subject.validate(value)).to be(true)
          end
        end

        context "and it's of the format \\xAA\\xBB\\xCC\\xDD\\xEE\\xFF" do
          let(:value) { "\\xAA\\xBB\\xCC\\xDD\\xEE\\xFF" }

          it "must return true" do
            expect(subject.validate(value)).to be(true)
          end
        end

        context "but it contains non-hex characters" do
          let(:value) { "abcxyz123" }

          it "must return [false, \"must be of the format 0xAABBCCDDEEFF..., AABBCCDDEEFF..., or \\\\xAA\\\\xBB\\\\xCC\\\\xDD\\\\xEE\\\\xFF...\"]" do
            expect(subject.validate(value)).to eq(
              [false,  "must be of the format 0xAABBCCDDEEFF..., AABBCCDDEEFF..., or \\xAA\\xBB\\xCC\\xDD\\xEE\\xFF..."]
            )
          end
        end
      end
    end
  end

  describe described_class::ScanFlags do
    describe "#validate" do
      context "when given nil" do
        let(:value) { nil }

        it "must return [false, \"cannot be nil\"]" do
          expect(subject.validate(value)).to eq(
            [false, "cannot be nil"]
          )
        end
      end

      context "when given a String" do
        context "but it's empty" do
          let(:value) { '' }

          it "must return [false, \"does not allow an empty value\"]" do
            expect(subject.validate(value)).to eq(
              [false, "does not allow an empty value"]
            )
          end
        end

        context "and it's made up of 'URG', 'ACK', 'PSH', 'RST', 'SYN', and 'FIN'" do
          let(:value) { 'URGACKPSHRSTSYNFIN' }

          it "must return true" do
            expect(subject.validate(value)).to be(true)
          end
        end

        context "but it contains other sub-strings besides 'URG', 'ACK', 'PSH', 'RST', 'SYN', and 'FIN'" do
          let(:value) { 'URGACKPSHRSTSYNFINXXX' }

          it "must return [false, \"must only contain URG, ACK, PSH, RST, SYN, or FIN\"]" do
            expect(subject.validate(value)).to eq(
              [false, "must only contain URG, ACK, PSH, RST, SYN, or FIN"]
            )
          end
        end

        context "and it's numeric" do
          let(:value) { '9' }

          it "must return true" do
            expect(subject.validate(value)).to be(true)
          end
        end
      end

      context "when given an Integer" do
        let(:value) { 9 }

        it "must return true" do
          expect(subject.validate(value)).to be(true)
        end
      end

      context "when given an Array" do
        context "but it's empty" do
          let(:value) { [] }

          it "must return [false, \"Array value cannot be empty\"]" do
            expect(subject.validate(value)).to eq(
              [false, "Array value cannot be empty"]
            )
          end
        end

        context "and it contains :urg, :ack, :psh, :rst, :syn, or :fin" do
          let(:value) { [:urg, :ack, :psh, :rst, :syn, :fin] }

          it "must return true" do
            expect(subject.validate(value)).to be(true)
          end
        end

        context "but it contains other values besides :urg, :ack, :psh, :rst, :syn, and :fin" do
          let(:other) { :foo }
          let(:value) { [:urg, :ack, :psh, :rst, :syn, :fin, other] }

          it "must return true" do
            expect(subject.validate(value)).to eq(
              [false, "Array must only contain the values :urg, :ack, :psh, :rst, :syn, or :fin"]
            )
          end
        end
      end

      context "when given a Hash" do
        context "but it's empty" do
          let(:value) { {} }

          it "must return [false, \"Hash value cannot be empty\"]" do
            expect(subject.validate(value)).to eq(
              [false, "Hash value cannot be empty"]
            )
          end
        end

        context "and it's keys contain :urg, :ack, :psh, :rst, :syn, or :fin" do
          context "and it's values are all Boolean" do
            let(:value) do
              {
                urg: true,
                ack: true,
                psh: false,
                rst: nil,
                syn: true,
                fin: true
              }
            end

            it "must return true" do
              expect(subject.validate(value)).to be(true)
            end
          end

          context "but one of it's values is not a Boolean value" do
            let(:value) do
              {
                urg: true,
                ack: true,
                psh: false,
                rst: nil,
                syn: true,
                fin: "foo"
              }
            end

            it "must return [false, \"must only contain the Boolean values\"]" do
              expect(subject.validate(value)).to eq(
                [false, "Hash must only contain the values true, false, or nil"]
              )
            end
          end
        end

        context "but it's keys contains other values besides :urg, :ack, :psh, :rst, :syn, and :fin" do
          let(:other) { :foo }
          let(:value) do
            {
              urg: true,
              ack: true,
              psh: true,
              rst: true,
              syn: true,
              fin: true,
              other => true
            }
          end

          it "must return [false, \"must only contain the keys :urg, :ack, :psh, :rst, :syn, or :fin\"]" do
            expect(subject.validate(value)).to eq(
              [false, "Hash must only contain the keys :urg, :ack, :psh, :rst, :syn, or :fin"]
            )
          end
        end
      end
    end

    describe "#format" do
      context "when given a String" do
        let(:value) { 'PSHFIN' }

        it "must return the String" do
          expect(subject.format(value)).to eq(value)
        end
      end

      context "when given an Integer" do
        let(:value) { 9 }

        it "must return the String version of the Integer" do
          expect(subject.format(value)).to eq(value.to_s)
        end
      end

      context "when given an Array" do
        let(:value) { [:urg, :ack, :psh, :rst, :syn, :fin] }

        it "must map each Symbol to their flag names value and join them together" do
          expect(subject.format(value)).to eq("URGACKPSHRSTSYNFIN")
        end
      end

      context "when given a Hash" do
        let(:value) do
          {
            urg: true,
            ack: true,
            psh: false,
            rst: nil,
            syn: true,
            fin: true
          }
        end

        it "must map the keys with true values to their flag names and join them together" do
          expect(subject.format(value)).to eq("URGACKSYNFIN")
        end
      end
    end
  end
end
