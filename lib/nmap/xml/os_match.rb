# frozen_string_literal: true

module Nmap
  class XML
    #
    # Represents a match for a specific {OS}.
    #
    # @since 1.0.0
    #
    class OSMatch < Struct.new(:name, :accuracy)

      #
      # Converts the OS match to a String.
      #
      # @return [String]
      #   The String form of the OS match.
      #
      def to_s
        "#{self.name} (#{self.accuracy}%)"
      end

    end
  end
end
