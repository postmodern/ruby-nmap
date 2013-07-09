module Nmap
  #
  # Represents an {OS} class.
  #
  class OSClass < Struct.new(:type, :vendor, :family, :gen, :accuracy)

    #
    # Converts the OS class to a String.
    #
    # @return [String]
    #   The String form of the OS class.
    #
    def to_s
      "#{self.type} #{self.vendor} (#{self.accuracy}%)"
    end

  end
end
