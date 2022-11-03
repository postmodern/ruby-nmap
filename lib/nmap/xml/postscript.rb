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

      def initialize(node)
        @node = node
      end

    end
  end
end