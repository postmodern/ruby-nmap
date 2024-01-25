# frozen_string_literal: true

require_relative 'scripts'

module Nmap
  class XML
    #
    # Represents the `prescript` element.
    #
    # @since 1.0.0
    #
    class Prescript

      include Scripts

      #
      # Initializes the Prescript object.
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
