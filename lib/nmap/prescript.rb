require 'nmap/scripts'

module Nmap
  #
  # Represents the `prescript` element.
  #
  class Prescript

    include Scripts

    def initialize(node)
      @node = node
    end

  end
end
