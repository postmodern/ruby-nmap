module Nmap
  #
  # Represents an IP or MAC address and Vendor name.
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
