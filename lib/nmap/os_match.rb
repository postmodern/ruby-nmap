module Nmap
  class OSMatch

    attr_reader :name

    attr_reader :accuracy

    def initialize(name,accuracy)
      @name = name
      @accuracy = accuracy
    end

    def to_s
      "#{@name} (#{@accuracy}%)"
    end

  end
end
