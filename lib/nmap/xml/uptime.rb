module Nmap
  class XML
    #
    # Wraps a `uptime` XML element.
    #
    # @since 1.0.0
    #
    class Uptime < Struct.new(:seconds, :last_boot)

      #
      # Converts the uptime object to a String.
      #
      # @return [String]
      #   The String form of the Uptime.
      #
      def to_s
        "uptime: #{self.seconds} (#{self.last_boot})"
      end

    end
  end
end
