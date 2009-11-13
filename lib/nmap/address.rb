module Nmap
  class Address

    # Type of the address
    attr_reader :type

    # Address
    attr_reader :addr

    #
    # Creates a new Address object.
    #
    # @param [Symbol] type
    #   The type of the address.
    #
    # @param [String] addr
    #   The address.
    #
    def initialize(type,addr)
      @type = type
      @addr = addr
    end

    #
    # Converts the address to a String.
    #
    # @return [String]
    #   The address.
    #
    def to_s
      @addr.to_s
    end

  end
end
