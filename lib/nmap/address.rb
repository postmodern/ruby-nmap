module Nmap
  class Address

    # Type of the address
    attr_reader :type

    # Address
    attr_reader :addr

    def initialize(type,addr)
      @type = type
      @addr = addr
    end

    def to_s
      @addr.to_s
    end

  end
end
