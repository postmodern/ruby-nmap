require 'nmap/scripts'

module Nmap
  #
  # Represents the `hostscript` element.
  #
  # @since 0.9.0
  #
  class HostScript

    include Scripts

    def initialize(node)
      @node = node
    end

  end
end
