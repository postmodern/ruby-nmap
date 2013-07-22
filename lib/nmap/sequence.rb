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
    # @since 0.5.0
    #
    def initialize(node)
      @node = node
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
      @description ||= @node['class']
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
      @values ||= if @node['values']
                    @node['values'].split(',').map { |value| value.to_i(16) }
                  else
                    []
                  end
    end

  end
end
