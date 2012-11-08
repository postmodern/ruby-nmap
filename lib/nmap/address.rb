module Nmap
  #
  # Represents a IP or MAC address.
  #
  class Address < Struct.new(:type, :addr)

    #
    # Converts the address to a String.
    #
    # @return [String]
    #   The address.
    #
    def to_s
      self.addr.to_s
    end

  end
end
