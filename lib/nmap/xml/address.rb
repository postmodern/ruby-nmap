module Nmap
  class XML
    #
    # Represents an IP or MAC address and Vendor name.
    #
    # @since 1.0.0
    #
    class Address < Struct.new(:type, :addr, :vendor)

      #
      # Initializes the address.
      #
      # @param [Symbol] type
      #   The type of address.
      #
      # @param [String] addr
      #   The address.
      #
      # @param [String, nil] vendor
      #   The optional vendor.
      #
      def initialize(type,addr,vendor=nil)
        super(type,addr,vendor)
      end

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
end
