require 'nmap/task'

require 'rprogram/program'

module Nmap
  class Program < RProgram::Program

    name_program 'nmap'

    #
    # Perform an Nmap scan.
    #
    # @param [Hash{Symbol => Object}] options
    #   Additional options for nmap.
    #
    # @yield [task]
    #   If a block is given, it will be passed a task object
    #   used for specifying options for nmap.
    #
    # @yieldparam [Task] task
    #   The nmap task object.
    #
    # @return [Boolean]
    #   Specifies whether the command exited normally.
    #
    # @see Task
    # @see #scan
    #
    def self.scan(options={},&block)
      self.find.scan(options,&block)
    end

    #
    # Perform an Nmap scan.
    #
    # @param [Hash{Symbol => Object}] options
    #   Additional options for nmap.
    #
    # @yield [task]
    #   If a block is given, it will be passed a task object
    #   used for specifying options for nmap.
    #
    # @yieldparam [Task] task
    #   The nmap task object.
    #
    # @return [Boolean]
    #   Specifies whether the command exited normally.
    #
    # @see Task
    #
    def scan(options={},&block)
      run_task(Task.new(options,&block))
    end

  end
end
