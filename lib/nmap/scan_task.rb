module Nmap
  class ScanTask

    # The name of the scan task
    attr_reader :name

    # The time the scan task begun
    attr_reader :start_time

    # The time the scan task ended
    attr_reader :stop_time

    # Extra information on the scan task
    attr_reader :extrainfo

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
      @name = name
      @start_time = start_time
      @end_time = end_time
      @extrainfo = extrainfo
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
      (@end_time - @start_time)
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
      "#{@start}: #{@name} (#{@extrainfo})"
    end

  end
end
