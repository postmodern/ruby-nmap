require 'nmap/scripts'

module Nmap
  #
  # Represents the `postscript` element.
  #
  class Postscript

    include Scripts

    def initialize(node)
      @node = node
    end

  end
end
