module Nmap
  class Port

    # The protocol the port runs on
    attr_reader :protocol

    # The port number
    attr_reader :number

    # The state of the port
    attr_reader :state

    # The reason the port was discovered
    attr_reader :reason

    # The service the port provides
    attr_reader :service

    #
    # Creates a new Port object.
    #
    # @param [Integer] protocol
    #   The protocol the port runs on.
    #
    # @param [Integer] number
    #   The port number.
    #
    # @param [Symbol] state
    #   The state the port is in.
    #
    # @param [String] reason
    #   The reason for the ports state.
    #
    # @param [String] service
    #   The name of the service that runs on the port.
    #
    def initialize(protocol,number,state,reason,service=nil)
      @protocol = protocol
      @number = number
      @state = state
      @reason = reason
      @service = service
    end

    #
    # Converts the port to an Integer.
    #
    # @return [Integer]
    #   The port number.
    #
    def to_i
      @number.to_i
    end

    #
    # Converts the port to a String.
    #
    # @return [String]
    #   The port number.
    #
    def to_s
      @number.to_s
    end

  end
end
