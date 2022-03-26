require 'nmap/xml/scripts'

module Nmap
  class XML
    #
    # Represents the `hostscript` element.
    #
    # @since 1.0.0
    #
    class HostScript

      include Scripts

      def initialize(node)
        @node = node
      end

    end
  end
end
