module Nmap
  class Sequence

    #
    # Creates a new sequence object.
    #
    # @param [Nokogiri::XML::Node] node
    #   The node that contains the sequence information.
    #
    # @yield [sequence]
    #   If a block is given, it will passed the newly created sequence.
    #
    # @yieldparam [Sequence] sequence
    #   The newly created sequence object.
    #
    # @since 0.5.0
    #
    def initialize(node)
      @node = node

      yield self if block_given?
    end

    #
    # The description of the sequence.
    #
    # @return [String]
    #   The sequence class from nmap.
    # 
    # @since 0.5.0
    #
    def description
      @node['class']
    end

    #
    # The values within the sequence.
    #
    # @return [Array<Numeric>]
    #   A sample of sequence numbers taken by nmap.
    #
    # @since 0.5.0
    #
    def values
      (@node['values'] || "").split(/\s*,\s*/).map {|v| v.to_i(16) }
    end

  end
end
