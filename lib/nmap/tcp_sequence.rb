require 'nmap/sequence'

module Nmap
  #
  # Represents a TCP sequence number.
  #
  # @since 0.5.0
  #
  class TcpSequence < Sequence

    #
    # @return [Numeric]
    #   The difficulty index from nmap
    #
    # @since 0.5.0
    #   
    def index
      @index ||= if (index_string = @node['index'])
                   index_string.to_i
                 end
    end

    #
    # @return [String]
    #   The difficulty description from nmap
    #
    # @since 0.5.0
    #
    def difficulty
      @difficulty ||= @node['difficulty']
    end

    #
    # Converts the TcpSequence class to a String.
    #
    # @return [String]
    #   The String form of the object.
    #
    # @since 0.5.0
    #
    def to_s
      "index=#{index} difficulty=#{difficulty.inspect} values=#{values.inspect}"
    end

  end
end
