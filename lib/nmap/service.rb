module Nmap
  #
  # @since 0.6.0
  #
  class Service

    #
    # Creates a new OS object.
    #
    # @param [Nokogiri::XML::Node] node
    #   The node that contains the OS guessing information.
    #
    def initialize(node)
      @node = node
    end

    #
    # The name of the service.
    #
    # @return [String]
    #   The service name.
    #
    def name
      @name ||= @node.get_attribute('name')
    end

    #
    # The product of the service.
    #
    # @return [String]
    #   The product name.
    #
    def product
      @product ||= @node.get_attribute('product')
    end

    #
    # The version of the service.
    #
    # @return [String]
    #   The service version.
    #
    def version
      @version ||= @node.get_attribute('version')
    end

    #
    # The hostname reported by the service.
    #
    # @return [String]
    #   The reported hostname.
    #
    def hostname
      @hostname ||= @node.get_attribute('hostname')
    end

    #
    # The fingerprint method used to identify the service.
    #
    # @return [Symbol]
    #   The fingerprint method.
    #
    def fingerprint_method
      @fingerprint_method ||= @node.get_attribute('method').to_sym
    end

    #
    # The confidence score of the service fingerprinting.
    #
    # @return [Integer]
    #   The confidence score.
    #
    def confidence
      @confidence ||= @node.get_attribute('conf').to_i
    end

    #
    # @see #name
    #
    def to_s
      name
    end

  end
end
