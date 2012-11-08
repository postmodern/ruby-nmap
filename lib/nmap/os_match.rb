module Nmap
  #
  # Represents a match for a specific {OS}.
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
