module Nmap
  #
  # Wraps a `uptime` XML element.
  #
  class Uptime < Struct.new(:seconds, :lastboot)

    #
    # Converts the uptime object to a String.
    #
    # @return [String]
    #   The String form of the Uptime.
    #
    # @since 0.6.1
    #
    def to_s
      "uptime: #{@seconds} (#{@lastboot})"
    end

  end
end
