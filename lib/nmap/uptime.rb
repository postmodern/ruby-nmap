module Nmap
  #
  # Wraps a `uptime` XML element.
  #
  class UpTime

    #
    # Creates a new UpTime object.
    #
    # @param [Nokogiri::XML::Element] node
    #   The XML `uptime` element.
    #
    def initialize(node)
      @node = node
    end

    #
    # The uptime of the host
    #
    # @return [Integer]
    #   The seconds of uptime.
    #
    def seconds
      @seconds ||= @node['seconds'].to_i
    end

    #
    # The lastboot date.
    #
    # @return [String]
    #   The date of the last boot.
    #
    def lastboot
      @lastboot ||= @node['lastboot'].to_s
    end

    #
    # Converts the uptime object to a String.
    #
    # @return [String]
    #   The String form of the UpTime.
    #
    # @since 0.6.1
    #
    def to_s
      "uptime: #{@seconds} (#{@lastboot})"
    end

  end
end
