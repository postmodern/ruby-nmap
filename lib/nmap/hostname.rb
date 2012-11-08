module Nmap
  #
  # Represents a hostname.
  #
  # @since 0.7.0
  #
  class Hostname < Struct.new(:type, :name)

    #
    # Converts the hostname to a String.
    #
    # @return [String]
    #   The name of the host.
    #
    def to_s
      self.name.to_s
    end

  end
end
