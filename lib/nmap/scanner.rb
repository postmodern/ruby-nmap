module Nmap
  #
  # Describes the `nmap` command.
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
