# frozen_string_literal: true

require_relative 'hop'

module Nmap
  class XML
    #
    # Wraps the `trace` XML element.
    #
    # @since 1.0.0
    #
    class Traceroute

      include Enumerable

      #
      # Creates a new traceroute.
      #
      # @param [Nokogiri::XML::Element] node
      #   The `trace` XML element.
      #
      def initialize(node)
        @node = node
      end

      #
      # The port used for the traceroute.
      #
      # @return [Integer, nil]
      #   The `port` XML attribute.
      #
      def port
        @port ||= if @node['port']
                    @node['port'].to_i
                  end
      end

      #
      # The protocol used for the traceroute.
      #
      # @return [Symbol, nil]
      #   The `proto` XML element.
      #
      def protocol
        @protocol ||= if @node['proto']
                        @node['proto'].to_sym
                      end
      end

      #
      # Parses the traceroute information for the host.
      #
      # @yield [hop]
      #   Each hop to the host.
      #
      # @yieldparam [Hop] hop
      #   A hop to the host.
      #
      # @return [Traceroute, Enumerator]
      #   The traceroute.
      #   If no block was given, an enumerator will be returned.
      #
      def each
        return enum_for(__method__) unless block_given?

        @node.xpath('hop').each do |hop|
          yield Hop.new(hop['ipaddr'],hop['host'],hop['ttl'],hop['rtt'])
        end

        return self
      end

    end
  end
end
