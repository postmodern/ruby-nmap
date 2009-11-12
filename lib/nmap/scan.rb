module Nmap
  class Scan

    attr_reader :type

    attr_reader :protocol

    attr_reader :services

    def initialize(type,protocol,services=[])
      @type = type
      @protocol = protocol
      @services = services
    end

    def to_s
      "#{@protocol} #{@type}"
    end

  end
end
