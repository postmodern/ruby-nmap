require 'nmap/task'

require 'rprogram/program'

module Nmap
  class Program < RProgram::Program

    name_program 'nmap'
    alias_program 'nmap.exe'

    #
    # Finds the `nmap` program and performs a scan.
    #
    # @param [Hash{Symbol => Object}] options
    #   Additional options for nmap.
    #
    # @yield [task]
    #   If a block is given, it will be passed a task object
    #   used to specify options for nmap.
    #
    # @yieldparam [Task] task
    #   The nmap task object.
    #
    # @return [Boolean]
    #   Specifies whether the command exited normally.
    #
    # @example Specifying Nmap options via a Hash.
    #   Nmap::Program.scan(
    #     :targets => '192.168.1.1',
    #     :ports => [22,80,443],
    #     :verbose => true
    #   )
    #
    # @example Specifying Nmap options via a {Task} object.
    #   Nmap::Program.scan do |nmap|
    #     nmap.targets = '192.168.1.1'
    #     nmap.ports = [22,80,443]
    #     nmap.verbose = true
    #   end
    #
    def self.scan(options={},&block)
      self.find.scan(options,&block)
    end

    #
    # Performs a scan.
    #
    # @param [Hash{Symbol => Object}] options
    #   Additional options for nmap.
    #
    # @yield [task]
    #   If a block is given, it will be passed a task object
    #   used to specify options for nmap.
    #
    # @yieldparam [Task] task
    #   The nmap task object.
    #
    # @return [Boolean]
    #   Specifies whether the command exited normally.
    #
    def scan(options={},&block)
      run_task(Task.new(options,&block))
    end

  end
end
