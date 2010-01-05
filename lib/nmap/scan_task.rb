module Nmap
  class ScanTask

    # The name of the scan task
    attr_reader :name

    # The time the scan task begun
    attr_reader :start

    # The time the scan task ended
    attr_reader :stop

    # Extra information on the scan task
    attr_reader :extrainfo

    #
    # Creates a new ScanTask object.
    #
    # @param [String] name
    #   The name of the scan task.
    #
    # @param [Time] start
    #   The time the scan task begun.
    #
    # @param [Time] stop
    #   The time the scan task ended.
    #
    # @param [String] extrainfo
    #   Any extra information relating to the scan task.
    #
    # @since 0.1.2
    #
    def initialize(name,start,stop,extrainfo=nil)
      @name = name
      @start = start
      @stop = stop
      @extrainfo = extrainfo
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
