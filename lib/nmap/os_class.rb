module Nmap
  class OSClass

    attr_reader :type

    attr_reader :vendor

    attr_reader :family

    attr_reader :accuracy

    def initialize(type,vendor,family,accuracy)
      @type = type
      @vendor = vendor
      @family = family
      @accuracy = accuracy
    end

    def to_s
      "#{@type} #{@vendor} (#{@accuracy}%)"
    end

  end
end
