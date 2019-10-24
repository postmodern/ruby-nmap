module Nmap
  #
  # Represents the Status of a {Host}.
  #
  class Status < Struct.new(:state, :reason, :reason_ttl)

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
