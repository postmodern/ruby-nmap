require 'nmap/xml/scripts'

module Nmap
  class XML
    #
    # Represents the `postscript` element.
    #
    # @since 1.0.0
    #
    class Postscript

      include Scripts

      #
      # Initializes the Postscript object.
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
