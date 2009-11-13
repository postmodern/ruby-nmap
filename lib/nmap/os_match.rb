module Nmap
  class OSMatch

    # The name of the OS
    attr_reader :name

    # The accuracy of the OS guess
    attr_reader :accuracy

    #
    # Creates a OSMatch object.
    #
    # @param [String] name
    #   The name of the OS.
    #
    # @param [Integer] accuracy
    #   The accuracy of the OS guess.
    #
    def initialize(name,accuracy)
      @name = name
      @accuracy = accuracy
    end

    #
    # Converts the OS match to a String.
    #
    # @return [String]
    #   The String form of the OS match.
    #
    def to_s
      "#{@name} (#{@accuracy}%)"
    end

  end
end
