require 'nmap/sequence'

module Nmap
  #
  # Represents a TCP timestamp.
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
