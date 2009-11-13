module Nmap
  class Scan

    # The type of scan
    attr_reader :type

    # The protocol used for the scan
    attr_reader :protocol

    # The port numbers that were scanned
    attr_reader :services

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
      @type = type
      @protocol = protocol
      @services = services
    end

    #
    # Converts the scan to a String.
    #
    # @return [String]
    #   The String form of the scan.
    #
    def to_s
      "#{@protocol} #{@type}"
    end

  end
end
