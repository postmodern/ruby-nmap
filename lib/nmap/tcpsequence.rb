module Nmap
  class TcpSequence

    #
    # Creates a new TcpSequence object.
    #
    # @param [Nokogiri::XML::Node] node
    #   The node that contains the TcpSequence information.
    #
    # @yield [tcpsequence]
    #   If a block is given, it will passed the newly created object.
    #
    # @yieldparam [TcpSequence] tcpsequence
    #   The newly created TcpSequence object.
    #
    def initialize(node)
      @node = node

      yield self if block_given?
    end

    # @return [Numeric]
    #   The difficulty index from nmap
    #   
    def index
      if idx = @node['index']
        idx.to_i
      end
    end

    #
    # @return [String]
    #   The difficulty description from nmap
    def difficulty
      @node['difficulty']
    end

    # @return [Array<Numeric>]
    #   A sample of sequence numbers taken by nmap
    def values
      (@node['values'] || "").split(/\s*,\s*/).map {|v| v.to_i(16) }
    end


    #
    # Converts the TcpSequence class to a String.
    #
    # @return [String]
    #   The String form of the object.
    #
    def to_s
      "index=#{self.index} difficulty=#{self.difficulty.inspect} values=#{self.values.inspect}"
    end

  end
end
