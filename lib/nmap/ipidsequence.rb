module Nmap
  class IpidSequence

    #
    # Creates a new IpidSequence object.
    #
    # @param [Nokogiri::XML::Node] node
    #   The node that contains the IpidSequence information.
    #
    # @yield [ipidsequence]
    #   If a block is given, it will passed the newly created object.
    #
    # @yieldparam [IpidSequence] ipidsequence
    #   The newly created IpidSequence object.
    #
    def initialize(node)
      @node = node

      yield self if block_given?
    end

    # @return [String]
    #   The ipidsequence class from nmap
    def description
      @node['class']
    end

    # @return [Array<Numeric>]
    #   A sample of timestamp sequence numbers taken by nmap
    def values
      (@node['values'] || "").split(/\s*,\s*/).map {|v| v.to_i(16) }
    end

    #
    # Converts the IpidSequence class to a String.
    #
    # @return [String]
    #   The String form of the object.
    #
    def to_s
      "description=#{self.description.inspect} values=#{self.values.inspect}"
    end

  end
end

