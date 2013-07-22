module Nmap
  class ScanTask < Struct.new(:name, :start_time, :end_time, :extrainfo)

    #
    # Creates a new ScanTask object.
    #
    # @param [String] name
    #   The name of the scan task.
    #
    # @param [Time] start_time
    #   The time the scan task begun.
    #
    # @param [Time] end_time
    #   The time the scan task ended.
    #
    # @param [String] extrainfo
    #   Any extra information relating to the scan task.
    #
    # @since 0.1.2
    #
    def initialize(name,start_time,end_time,extrainfo=nil)
      super
    end

    #
    # The duration of the scan task.
    #
    # @return [Integer]
    #   The number of seconds it took the scan task to complete.
    #
    # @since 0.1.2
    #
    def duration
      (self.end_time - self.start_time)
    end

    #
    # Converts the scan task to a String.
    #
    # @return [String]
    #   The String form of the scan task.
    #
    # @since 0.1.2
    #
    def to_s
      "#{self.start_time}: #{self.name} (#{self.extrainfo})"
    end

  end
end
