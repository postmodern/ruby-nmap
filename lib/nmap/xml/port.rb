# frozen_string_literal: true

require_relative 'service'
require_relative 'scripts'

module Nmap
  class XML
    #
    # Wraps a `port` XML element.
    #
    # @since 1.0.0
    #
    class Port

      include Scripts

      #
      # Creates a new Port object.
      #
      # @param [Nokogiri::XML::Element] node
      #   The XML `port` element.
      #
      def initialize(node)
        @node = node
      end

      #
      # The protocol the port runs on
      #
      # @return [Symbol]
      #   The protocol of the port.
      #
      def protocol
        @protocol ||= @node['protocol'].to_sym
      end

      #
      # The port number.
      #
      # @return [Integer]
      #   The number of the port.
      #
      def number
        @number ||= @node['portid'].to_i
      end

      #
      # The state of the port.
      #
      # @return [Symbol]
      #   The state of the port (`:open`, `:filtered` or `:closed`).
      #
      def state
        @state ||= @node.at_xpath('state/@state').inner_text.to_sym
      end

      #
      # The reason the port was discovered.
      #
      # @return [String]
      #   How the port was discovered.
      #
      def reason
        @reason ||= @node.at_xpath('state/@reason').inner_text
      end

      #
      # The reason TTL.
      #
      # @return [Integer]
      #
      # @since 0.10.0
      #
      def reason_ttl
        @reason ||= @node.at_xpath('state/@reason_ttl').inner_text.to_i
      end

      #
      # The fingerprinted service of the port.
      #
      # @return [Service]
      #   The service detected on the port.
      #
      # @since 0.6.0
      #
      def service
        @service_info ||= if (service = @node.at_xpath('service'))
                            Service.new(service)
                          end
      end

      alias to_i number

      #
      # Converts the port to a String.
      #
      # @return [String]
      #   The port number.
      #
      def to_s
        number.to_s
      end

      #
      # Inspects the port.
      #
      # @return [String]
      #   The inspected port.
      #
      def inspect
        "#<#{self.class}: #{self}>"
      end

    end
  end
end
