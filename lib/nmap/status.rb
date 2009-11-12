module Nmap
  class Status

    attr_reader :state

    attr_reader :reason

    def initialize(state,reason)
      @state = state
      @reason = reason
    end

    def to_s
      @state.to_s
    end

  end
end
