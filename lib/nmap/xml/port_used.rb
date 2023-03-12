# frozen_string_literal: true

module Nmap
  class XML
    #
    # Represents a port used to perform OS fingerprinting.
    #
    # @since 1.1.0
    #
    class PortUsed < Struct.new(:state,:protocol,:port)

      alias to_i port
      alias to_int port

    end
  end
end
