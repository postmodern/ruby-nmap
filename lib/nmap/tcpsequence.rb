require 'nmap/sequence'

module Nmap
  class TcpSequence < Sequence

    #
    # @return [Numeric]
    #   The difficulty index from nmap
    #
    # @since 0.5.0
    #   
    def index
      if idx = @node['index']
        idx.to_i
      end
    end

    #
    # @return [String]
    #   The difficulty description from nmap
    #
    # @since 0.5.0
    #
    def difficulty
      @node['difficulty']
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
      "index=#{self.index} difficulty=#{self.difficulty.inspect} values=#{self.values.inspect}"
    end

  end
end
