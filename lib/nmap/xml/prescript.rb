require 'nmap/xml/scripts'

module Nmap
  class XML
    #
    # Represents the `prescript` element.
    #
    # @since 1.0.0
    #
    class Prescript

      include Scripts

      def initialize(node)
        @node = node
      end

    end
  end
end
