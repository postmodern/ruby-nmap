module Nmap
  class Status

    # The state of a host
    attr_reader :state

    # The reason of the state
    attr_reader :reason

    #
    # Creates a new Status object.
    #
    # @param [Symbol] state
    #   The state of a host.
    #
    # @param [String] reason
    #   The reason for the state.
    #
    def initialize(state,reason)
      @state = state
      @reason = reason
    end

    #
    # Converts the status to a String.
    #
    # @return [String]
    #   The state.
    #
    def to_s
      @state.to_s
    end

  end
end
