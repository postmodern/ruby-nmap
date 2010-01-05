require 'nmap/scanner'
require 'nmap/scan_task'
require 'nmap/scan'
require 'nmap/host'

require 'nokogiri'
require 'enumerator'

module Nmap
  class XML

    include Enumerable

    # Path of the Nmap XML scan file
    attr_reader :path

    #
    # Creates a new XML object.
    #
    # @param [String] path
    #   The path to the Nmap XML scan file.
    #
    # @yield [xml]
    #   If a block is given, it will be passed the new XML object.
    #
    # @yieldparam [XML] xml
    #   The newly created XML object.
    #
    def initialize(path,&block)
      @path = File.expand_path(path)
      @doc = Nokogiri::XML(File.new(@path))

      block.call(self) if block
    end

    #
    # Parses the scanner information.
    #
    # @return [Scanner]
    #   The scanner that was used and generated the scan file.
    #
    def scanner
      @scanner ||= Scanner.new(
        @doc.root['scanner'],
        @doc.root['version'],
        @doc.root['args'],
        Time.at(@doc.root['start'].to_i)
      )
    end

    #
    # Parses the XML scan file version.
    #
    # @return [String]
    #   The version of the XML scan file.
    #
    def version
      @version ||= @doc.root['xmloutputversion']
    end

    #
    # Parses the scan information.
    #
    # @return [Array<Scan>]
    #   The scan information.
    #
    def scan_info
      @doc.xpath('/nmaprun/scaninfo').map do |scaninfo|
        Scan.new(
          scaninfo['type'].to_sym,
          scaninfo['protocol'].to_sym,
          scaninfo['services'].split(',').map { |ports|
            if ports.include?('-')
              Range.new(*(ports.split('-',2)))
            else
              ports.to_i
            end
          }
        )
      end
    end

    #
    # Parses the verbose level.
    #
    # @return [Integer]
    #   The verbose level.
    #
    def verbose
      @verbose ||= @doc.at('verbose/@level').inner_text.to_i
    end

    #
    # Parses the debugging level.
    #
    # @return [Integer]
    #   The debugging level.
    #
    def debugging
      @debugging ||= @doc.at('debugging/@level').inner_text.to_i
    end

    #
    # Parses the tasks of the scan.
    #
    # @return [Array<ScanTask>]
    #   The tasks of the scan.
    #
    # @since 0.1.2
    #
    def tasks
      @doc.xpath('/nmaprun/taskbegin').map do |task_begin|
        task_end = task_begin.xpath('following-sibling::taskend').first

        ScanTask.new(
          task_begin['task'],
          Time.at(task_begin['time'].to_i),
          Time.at(task_end['time'].to_i),
          task_end['extrainfo']
        )
      end
    end

    #
    # Parses the hosts in the scan.
    #
    # @yield [host]
    #   Each host will be passed to a given block.
    #
    # @yieldparam [Host] host
    #   A host in the scan.
    #
    # @return [XML]
    #   The XML object.
    #
    def each_host(&block)
      @doc.xpath('/nmaprun/host').each do |host|
        block.call(Host.new(host)) if block
      end

      return self
    end

    #
    # Parses the hosts in the scan.
    #
    # @return [Array<Host>]
    #   The hosts in the scan.
    #
    def hosts
      Enumerator.new(self,:each_host).to_a
    end

    #
    # Parses the hosts that were found to be up during the scan.
    #
    # @yield [host]
    #   Each host will be passed to a given block.
    #
    # @yieldparam [Host] host
    #   A host in the scan.
    #
    # @return [XML]
    #   The XML parser.
    #
    def each_up_host(&block)
      @doc.xpath("/nmaprun/host[status[@state='up']]").each do |host|
        Host.new(host,&block)
      end

      return self
    end

    #
    # Parses the hosts found to be up during the scan.
    #
    # @return [Array<Host>]
    #   The hosts in the scan.
    #
    def up_hosts
      Enumerator.new(self,:each_up_host).to_a
    end

    #
    # Parses the hosts that were found to be up during the scan.
    #
    # @see each_up_hosts
    #
    def each(&block)
      each_up_hosts(&block)
    end

    #
    # Converts the XML parser to a String.
    #
    # @return [String]
    #   The path of the XML scan file.
    #
    def to_s
      @path.to_s
    end

  end
end
