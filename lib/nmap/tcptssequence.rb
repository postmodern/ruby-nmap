module Nmap
  class TcpTsSequence

    #
    # Creates a new TcpTsSequence object.
    #
    # @param [Nokogiri::XML::Node] node
    #   The node that contains the TcpTsSequence information.
    #
    # @yield [tcptssequence]
    #   If a block is given, it will passed the newly created object.
    #
    # @yieldparam [TcpTsSequence] tcptssequence
    #   The newly created TcpTsSequence object.
    #
    def initialize(node)
      @node = node

      yield self if block_given?
    end

    # @return [String]
    #   The tcptssequence class from nmap
    def description
      @node['class']
    end

    # @return [Array<Numeric>]
    #   A sample of timestamp sequence numbers taken by nmap
    def values
      (@node['values'] || "").split(/\s*,\s*/).map {|v| v.to_i(16) }
    end

    #
    # Converts the TcpTsSequence class to a String.
    #
    # @return [String]
    #   The String form of the object.
    #
    def to_s
      "description=#{self.description.inspect} values=#{self.values.inspect}"
    end

  end
end
