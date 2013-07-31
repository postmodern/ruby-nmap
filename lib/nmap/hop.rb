module Nmap
  #
  # Represents a hop in a traceroute.
  #
  # @since 0.7.0
  #
  class Hop < Struct.new(:addr, :host, :ttl, :rtt)

    #
    # Converts the hop to a String.
    #
    # @return [String]
    #   The IP address of the hop.
    #
    def to_s
      self.addr.to_s
    end

  end
end
