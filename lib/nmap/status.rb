module Nmap
  class Status < Struct.new(:state, :reason)

    #
    # Converts the status to a String.
    #
    # @return [String]
    #   The state.
    #
    def to_s
      self.state.to_s
    end

  end
end
