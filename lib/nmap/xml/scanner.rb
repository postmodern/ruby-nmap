# frozen_string_literal: true

module Nmap
  class XML
    #
    # Describes the `nmap` command.
    #
    # @since 1.0.0
    #
    class Scanner < Struct.new(:name, :version, :arguments, :start_time)

      #
      # Converts the scanner to a String.
      #
      # @return [String]
      #   The scanner name and arguments.
      #
      def to_s
        "#{self.name} #{self.arguments}"
      end

    end
  end
end
