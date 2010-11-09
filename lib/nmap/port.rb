module Nmap
  class Port

    #
    # Creates a new Port object.
    #
    # @param [Nokogiri::XML::Element] node
    #   The XML `port` element.
    #
    def initialize(node)
      @node = node
    end

    # The protocol the port runs on
    def protocol
      @protocol ||= @node['protocol'].to_sym
    end

    # The port number
    def number
      @number ||= @node['portid'].to_i
    end

    # The state of the port
    def state
      @state ||= @node.at('state/@state').inner_text.to_sym
    end

    # The reason the port was discovered
    def reason
      @reason ||= @node.at('state/@reason').inner_text
    end

    # The service the port provides
    def service
      @service ||= if (service = @node.at('service/@name'))
                     service.inner_text
                   end
    end

    #
    # The output from the NSE scripts ran against the open port.
    #
    # @return [Hash{String => String}]
    #   The NSE script names and output.
    #
    # @since 0.3.0
    #
    def scripts
      unless @scripts
        @scripts = {}

        @node.xpath('script').each do |script|
          @scripts[script['id']] = script['output']
        end
      end

      return @scripts
    end

    alias to_i number

    #
    # Converts the port to a String.
    #
    # @return [String]
    #   The port number.
    #
    def to_s
      self.number.to_s
    end

  end
end
