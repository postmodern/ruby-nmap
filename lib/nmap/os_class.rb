require 'nmap/cpe'

module Nmap
  #
  # Represents an {OS} class.
  #
  class OSClass

    include CPE

    #
    # Initializes the os class.
    #
    # @param [Nokogiri::XML::Node] node
    #   The node that contains the OS Class information.
    #
    def initialize(node)
      @node = node
    end

    #
    # The OS type.
    #
    # @return [String]
    #
    def type
      @type ||= if @node['type']
                  @node['type'].to_sym
                end
    end

    #
    # The OS vendor.
    #
    # @return [String]
    #
    def vendor
      @vendor ||= @node.get_attribute('vendor')
    end

    #
    # The OS family.
    #
    # @return [Symbol, nil]
    #
    def family
      @family ||= @node.get_attribute('osfamily').to_sym
    end

    #
    # The OS generation.
    #
    # @return [Symbol, nil]
    #
    def gen
      @gen ||= if @node['osgen']
                 @node['osgen'].to_sym
               end
    end

    #
    # The accuracy of the OS class information.
    #
    # @return [Integer]
    #   Returns a number between 0 and 10.
    #
    def accuracy
      @accuracy ||= @node.get_attribute('accuracy').to_i
    end

    #
    # Converts the OS class to a String.
    #
    # @return [String]
    #   The String form of the OS class.
    #
    def to_s
      "#{self.type} #{self.vendor} (#{self.accuracy}%)"
    end

  end
end
