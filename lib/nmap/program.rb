require 'nmap/task'

require 'rprogram/program'

module Nmap
  class Program < RProgram::Program

    name_program 'nmap'

    #
    # Perform an Nmap scan using the given _options_ and _block_.
    # If a _block_ is given, it will be passed a newly created
    # NmapTask object.
    #
    def self.scan(options={},&block)
      self.find.scan(options,&block)
    end

    #
    # Perform an Nmap scan using the given _options_ and _block_.
    # If a _block_ is given, it will be passed a newly created
    # NmapTask object.
    #
    def scan(options={},&block)
      run_task(Task.new(options,&block))
    end

  end
end
