require_relative 'sequence'

module Nmap
  class XML
    #
    # Represents an IP ID.
    #
    # @since 1.0.0
    #
    class IpIdSequence < Sequence

      #
      # Converts the IpidSequence class to a String.
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
