module Nmap
  class Scanner

    attr_reader :name

    attr_reader :version

    attr_reader :arguments

    def initialize(name,version,arguments=[])
      @name = name
      @version = version
      @arguments = arguments
    end

    def to_s
      "#{@name} #{@arguments}"
    end

  end
end
