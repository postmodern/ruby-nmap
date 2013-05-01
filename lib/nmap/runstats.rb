module Nmap
  #
  # Represents the runstats of a scan.
  #
  class RunStats < Struct.new(:end_time, :elapsed, :exit_status)

    #
    # Converts the stats to a String.
    #
    # @return [String]
    #   The String form of the scan.
    #
    def to_s
      "#{self.end_time} #{self.elapsed} #{self.exit_status}"
    end

  end
end