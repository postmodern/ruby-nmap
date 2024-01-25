# frozen_string_literal: true

require_relative 'scripts'

module Nmap
  class XML
    #
    # Represents the `hostscript` element.
    #
    # @since 1.0.0
    #
    class HostScript

      include Scripts

      #
      # Initializes the HostScript object.
      #
      # @param [Nokogiri::XML::Node] node
      #   The XML node that contains the host information.
      #
      def initialize(node)
        @node = node
      end

    end
  end
end
