require 'nmap/os_class'
require 'nmap/os_match'

require 'enumerator'

module Nmap
  class OS

    include Enumerable

    def initialize(node)
      @node = node
    end

    def each_class(&block)
      @node.xpath("osclass").map do |osclass|
        os_class = OSClass.new(
          osclass['type'].to_sym,
          osclass['vendor'],
          osclass['osfamily'].to_sym,
          osclass['accuracy'].to_i
        )

        block.call(os_class) if block
      end

      return self
    end

    def classes
      Enumerator.new(self,:each_class).to_a
    end

    def each_match(&block)
      @node.xpath("osmatch").map do |osclass|
        os_match = OSMatch.new(
          osclass['name'],
          osclass['accuracy'].to_i
        )

        block.call(os_match) if block
      end

      return self
    end

    def matches
      Enumerator.new(self,:each_match).to_a
    end

    def ports_used
      @node.xpath("portused/@portid").map { |port| port.inner_text.to_i }
    end

    def fingerprint
      @node.at("osfingerprint/@fingerprint").inner_text
    end

    def each(&block)
      each_match(&block)
    end

  end
end
