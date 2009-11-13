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

    # The service the port runs
    attr_reader :service

    def initialize(protocol,number,state,reason,service=nil)
      @protocol = protocol
      @number = number
      @state = state
      @reason = reason
      @service = service
    end

    def to_i
      @number.to_i
    end

    def to_s
      @number.to_s
    end

  end
end
