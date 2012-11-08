module Nmap
  #
  # Base class for all Sequence classes.
  #
  # @since 0.5.0
  #
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
      unless @values
        @values = []

        if (string = @node['values'])
          string.scan(/[^\s,]+/) { |match| @values << match.to_i(16) }
        end
      end

      return @values
    end

  end
end
