require 'nmap/task'

require 'rprogram/program'

module Nmap
  #
  # Represents the `nmap` program.
  #
  class Program < RProgram::Program

    name_program 'nmap'

    #
    # Finds the `nmap` program and performs a scan.
    #
    # @param [Hash{Symbol => Object}] options
    #   Additional options for nmap.
    #
    # @param [Hash{Symbol => Object}] exec_options
    #   Additional exec-options.
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
    # @see #scan
    #
    def self.scan(options={},exec_options={},&block)
      find.scan(options,exec_options,&block)
    end

    #
    # Finds the `nmap` program and performs a scan, but runs `nmap` under
    # `sudo`.
    #
    # @see scan
    #
    # @since 0.8.0
    #
    def self.sudo_scan(options={},exec_options={},&block)
      find.sudo_scan(options,exec_options,&block)
    end

    #
    # Performs a scan.
    #
    # @param [Hash{Symbol => Object}] options
    #   Additional options for nmap.
    #
    # @param [Hash{Symbol => Object}] exec_options
    #   Additional exec-options.
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
    # @see http://rubydoc.info/gems/rprogram/0.3.0/RProgram/Program#run-instance_method
    #   For additional exec-options.
    #
    def scan(options={},exec_options={},&block)
      run_task(Task.new(options,&block),exec_options)
    end

    #
    # Performs a scan and runs `nmap` under `sudo`.
    #
    # @see #scan
    #
    # @since 0.8.0
    #
    def sudo_scan(options={},exec_options={},&block)
      sudo_task(Task.new(options,&block),exec_options)
    end

  end
end
