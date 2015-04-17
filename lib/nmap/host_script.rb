require 'nmap/scripts'

module Nmap
  #
  # Represents the `hostscript` element.
  #
  class HostScript

    include Scripts

    def initialize(node)
      @node = node
    end

  end
end
