module Nmap
  #
  # Represents an Nmap scan.
  #
  class Scan < Struct.new(:type, :protocol, :services)

    #
    # Creates a new Scan object.
    #
    # @param [Symbol] type
    #   The type of the scan.
    #
    # @param [Symbol] protocol
    #   The protocol used for the scan.
    #
    # @param [Array<Integer, Rage>] services
    #   The port numbers scanned.
    #
    def initialize(type,protocol,services=[])
      super(type,protocol,services)
    end

    #
    # Converts the scan to a String.
    #
    # @return [String]
    #   The String form of the scan.
    #
    def to_s
      "#{self.protocol} #{self.type}"
    end

  end
end
