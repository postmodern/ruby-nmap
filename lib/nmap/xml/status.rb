# frozen_string_literal: true

module Nmap
  class XML
    #
    # Represents the Status of a {Host}.
    #
    # @since 1.0.0
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
end
