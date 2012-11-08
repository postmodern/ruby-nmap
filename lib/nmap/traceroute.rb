require 'nmap/hop'

module Nmap
  #
  # Wraps the `trace` XML element.
  #
  # @since 0.7.0
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
    # @return [Integer]
    #   The `port` XML attribute.
    #
    def port
      @port ||= @node['port'].to_i
    end

    #
    # The protocol used for the traceroute.
    #
    # @return [Symbol]
    #   The `proto` XML element.
    #
    def protocol
      @protocol ||= @node['proto'].to_sym
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
