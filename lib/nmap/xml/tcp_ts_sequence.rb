require 'nmap/xml/sequence'

module Nmap
  class XML
    #
    # Represents a TCP timestamp.
    #
    # @since 1.0.0
    #
    class TcpTsSequence < Sequence

      #
      # Converts the TcpTsSequence class to a String.
      #
      # @return [String]
      #   The String form of the object.
      #
      # @since 0.5.0
      #
      def to_s
        "description=#{description.inspect} values=#{values.inspect}"
      end

    end
  end
end
