module Nmap
  class OSClass

    # The OS class
    attr_reader :type

    # The OS vendor
    attr_reader :vendor

    # The family of the OS
    attr_reader :family

    # The accuracy of the OS guess
    attr_reader :accuracy

    #
    # Creates a new OSClass object.
    #
    # @param [Symbol] type
    #   The class of the OS.
    #
    # @param [String] vendor
    #   The vendor of the OS.
    #
    # @param [String] family
    #   The family of the OS.
    #
    # @param [Integer] accuracy
    #   The accuracy of the OS guess.
    #
    def initialize(type,vendor,family,accuracy)
      @type = type
      @vendor = vendor
      @family = family
      @accuracy = accuracy
    end

    #
    # Converts the OS class to a String.
    #
    # @return [String]
    #   The String form of the OS class.
    #
    def to_s
      "#{@type} #{@vendor} (#{@accuracy}%)"
    end

  end
end
