require 'nmap/cpe'

module Nmap
  #
  # Wraps a `service` XML element.
  #
  # @since 0.6.0
  #
  class Service

    include CPE

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
    # Determines if the service requires SSL.
    #
    # @return [Boolean]
    #   Checks whether the `tunnel` XML attribute is `ssl`.
    #
    # @since 0.7.0
    #
    def ssl?
      (@ssl ||= @node['tunnel']) == 'ssl'
    end

    #
    # The application protocol used by the service.
    #
    # @return [String]
    #   The `proto` XML attribute.
    #
    # @since 0.7.0
    #
    def protocol
      @protocol ||= @node['proto']
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
    # The extra information from the service scan.
    #
    # @return [String]
    #   The `extrainfo` XML attribute.
    #
    # @since 0.7.0
    #
    def extra_info
      @extra_info ||= @node['extrainfo']
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
    # The reported OS type.
    #
    # @return [String]
    #   The `ostype` XML attribute.
    #
    # @since 0.7.0
    #
    def os_type
      @os_type ||= @node['ostype']
    end

    #
    # The reported device type.
    #
    # @return [String]
    #   The `devicetype` XML attribute.
    #
    # @since 0.7.0
    #
    def device_type
      @device_type ||= @node['devicetype']
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
    # The actual fingerprint
    #
    # @return [String]
    #   The fingerprint
    #
    # @since 0.7.0
    #
    def fingerprint
      @fingerprint ||= @node.get_attribute('servicefp')
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

    alias to_s name

  end
end
