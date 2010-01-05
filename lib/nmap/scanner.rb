module Nmap
  class Scanner

    # The name of the scanner
    attr_reader :name

    # The version of the scanner
    attr_reader :version

    # The arguments used with the scanner
    attr_reader :arguments

    # The time the scan begun
    attr_reader :start_time

    #
    # Creates a new Scanner object.
    #
    # @param [String] name
    #   The name of the scanner.
    #
    # @param [String] version
    #   The version of the scanner.
    #
    # @param [String] arguments
    #   The arguments used with the scanner.
    #
    # @param [Time] start_time
    #   The time the scan begun
    #
    def initialize(name,version,arguments,start_time)
      @name = name
      @version = version
      @arguments = arguments
      @start_time = start_time
    end

    #
    # Converts the scanner to a String.
    #
    # @return [String]
    #   The scanner name and arguments.
    #
    def to_s
      "#{@name} #{@arguments}"
    end

  end
end
