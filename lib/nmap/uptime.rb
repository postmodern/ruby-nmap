module Nmap
  #
  # Wraps a `uptime` XML element.
  #
  # @since 0.7.0
  #
  class Uptime < Struct.new(:seconds, :lastboot)

    #
    # Converts the uptime object to a String.
    #
    # @return [String]
    #   The String form of the Uptime.
    #
    def to_s
      "uptime: #{self.seconds} (#{self.lastboot})"
    end

  end
end
