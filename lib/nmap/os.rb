require 'nmap/os_class'
require 'nmap/os_match'

require 'enumerator'

module Nmap
  class OS

    include Enumerable

    #
    # Creates a new OS object.
    #
    # @param [Nokogiri::XML::Node] node
    #   The node that contains the OS guessing information.
    #
    # @yield [os]
    #   If a block is given, it will passed the newly created OS object.
    #
    # @yieldparam [OS] os
    #   The newly created OS object.
    #
    def initialize(node,&block)
      @node = node

      block.call(self) if block
    end

    #
    # Parses the OS class information.
    #
    # @yield [class]
    #   Passes each OS class to the given block.
    #
    # @yieldparam [OSClass] class
    #   The OS class information.
    #
    # @return [OS]
    #   The OS information.
    #
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

    #
    # Parses the OS class information.
    #
    # @return [Array<OSClass>]
    #   The OS class information.
    #
    def classes
      Enumerator.new(self,:each_class).to_a
    end

    #
    # Parses the OS match information.
    #
    # @yield [match]
    #   Passes each OS match to the given block.
    #
    # @yieldparam [OSMatch] class
    #   The OS match information.
    #
    # @return [OS]
    #   The OS information.
    #
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

    #
    # Parses the OS match information.
    #
    # @return [Array<OSMatch>]
    #   The OS match information.
    #
    def matches
      Enumerator.new(self,:each_match).to_a
    end

    #
    # Parses the ports used for guessing the OS.
    #
    # @return [Array<Integer>]
    #   The ports used.
    #
    def ports_used
      @ports_used ||= @node.xpath("portused/@portid").map do |port|
        port.inner_text.to_i
      end
    end

    #
    # Parses the OS fingerprint used by Nmap.
    #
    # @return [String]
    #   The OS fingerprint.
    #
    def fingerprint
      @fingerprint ||= @node.at("osfingerprint/@fingerprint").inner_text
    end

    #
    # Parses the OS match information.
    #
    # @see each_match
    #
    def each(&block)
      each_match(&block)
    end

  end
end
