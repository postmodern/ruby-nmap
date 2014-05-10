module Nmap
  #
  # Represents the runstats of a scan.
  #
  # @since 0.7.0
  #
  class RunStat < Struct.new(:end_time, :elapsed, :summary, :exit_status)

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
