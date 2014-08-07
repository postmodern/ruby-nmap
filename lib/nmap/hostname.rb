module Nmap
  #
  # Represents a hostname.
  #
  # @since 0.7.0
  #
  class Hostname < Struct.new(:type, :name)

    #
    # Determines if the hostname was specified by the user.
    #
    # @return [Boolean]
    #
    # @since 0.8.0
    #
    def user?
      self.type == 'user'
    end

    #
    # Determines if the hostname is a DNS `PTR`.
    #
    # @return [Boolean]
    #
    # @since 0.8.0
    #
    def ptr?
      self.type == 'PTR'
    end

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
