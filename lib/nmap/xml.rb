require 'nmap/xml/scanner'
require 'nmap/xml/scan_task'
require 'nmap/xml/scan'
require 'nmap/xml/host'
require 'nmap/xml/run_stat'
require 'nmap/xml/prescript'
require 'nmap/xml/postscript'

require 'nokogiri'

module Nmap
  #
  # Represents an Nmap XML file.
  #
  class XML

    include Enumerable

    # The parsed XML document.
    #
    # @api private
    attr_reader :doc

    # Path of the Nmap XML scan file
    #
    # @return [String, nil]
    attr_reader :path

    #
    # Creates a new XML object.
    #
    # @param [Nokogiri::XML::Document] doc
    #   The path to the Nmap XML scan file or Nokogiri::XML::Document.
    #
    # @param [String, nil] path
    #   The optional path the XML was loaded from.
    #
    # @yield [xml]
    #   If a block is given, it will be passed the new XML object.
    #
    # @yieldparam [XML] xml
    #   The newly created XML object.
    #
    def initialize(doc, path: nil)
      @doc  = doc
      @path = File.expand_path(path) if path

      yield self if block_given?
    end

    #
    # Creates a new XML object from XML text.
    #
    # @param [String] text
    #   XML text of the scan file
    #
    # @yield [xml]
    #   If a block is given, it will be passed the new XML object.
    #
    # @yieldparam [XML] xml
    #   The newly created XML object.
    #
    # @since 0.8.0
    #
    def self.parse(text,&block)
      new(Nokogiri::XML(text),&block)
    end

    #
    # Creates a new XML object from the file.
    #
    # @param [String] path
    #   The path to the XML file.
    #
    # @yield [xml]
    #   If a block is given, it will be passed the new XML object.
    #
    # @yieldparam [XML] xml
    #   The newly created XML object.
    #
    # @since 0.7.0
    #
    def self.open(path,&block)
      path = File.expand_path(path)
      doc  = Nokogiri::XML(File.open(path))

      new(doc, path: path, &block)
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
    # Parses the essential runstats information.
    #
    # @yield [run_stat]
    #   The given block will be passed each runstat.
    #
    # @yieldparam [RunStat] run_stat
    #   A runstat.
    #
    # @return [Enumerator]
    #   If no block is given, an enumerator will be returned.
    #
    # @since 0.7.0
    #
    def each_run_stat
      return enum_for(__method__) unless block_given?

      @doc.xpath('/nmaprun/runstats/finished').each do |run_stat|
        yield RunStat.new(
          Time.at(run_stat['time'].to_i),
          run_stat['elapsed'],
          run_stat['summary'],
          run_stat['exit']
        )
      end

      return self
    end

    #
    # Parses the essential runstats information.
    #
    # @return [Array<RunStat>]
    #   The runstats.
    #
    # @since 0.7.0
    #
    def run_stats
      each_run_stat.to_a
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
    # @yield [task]
    #   The given block will be passed each scan task.
    #
    # @yieldparam [ScanTask] task
    #   A task from the scan.
    #
    # @return [Enumerator]
    #   If no block is given, an enumerator will be returned.
    #
    # @since 0.7.0
    #
    def each_task
      return enum_for(__method__) unless block_given?

      @doc.xpath('/nmaprun/taskbegin').each do |task_begin|
        task_end = task_begin.xpath('following-sibling::taskend').first

        yield ScanTask.new(
          task_begin['task'],
          Time.at(task_begin['time'].to_i),
          Time.at(task_end['time'].to_i),
          task_end['extrainfo']
        )
      end

      return self
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
      each_task.to_a
    end

    #
    # Finds the task with the given name.
    #
    # @param [String] name
    #   The task name to search for.
    #
    # @return [ScanTask, nil]
    #   The scan task with the matching name or `nil`.
    #
    # @since 0.10.0
    #
    def task(name)
      each_task.find { |scan_task| scan_task.name == name }
    end

    #
    # The NSE scripts ran before the scan.
    #
    # @return [Prescript]
    #   Contains the script output and data.
    #
    # @since 0.9.0
    #
    def prescript
      @prescript ||= if (prescript = @doc.at('prescript'))
                       Prescript.new(prescript)
                     end
    end

    alias prescripts prescript

    #
    # The NSE scripts ran after the scan.
    #
    # @return [Postscript]
    #   Contains the script output and data.
    #
    # @since 0.9.0
    #
    def postscript
      @postscript ||= if (postscript = @doc.at('postscript'))
                        Postscript.new(postscript)
                      end
    end

    alias postscripts postscript

    #
    # Parses the hosts in the scan.
    #
    # @yield [host]
    #   Each host will be passed to a given block.
    #
    # @yieldparam [Host] host
    #   A host in the scan.
    #
    # @return [XML, Enumerator]
    #   The XML object. If no block was given, an enumerator object will
    #   be returned.
    #
    def each_host
      return enum_for(__method__) unless block_given?

      @doc.xpath('/nmaprun/host').each do |host|
        yield Host.new(host)
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
      each_host.to_a
    end

    #
    # Returns the first host.
    #
    # @return [Host]
    #
    # @since 0.8.0
    #
    def host
      each_host.first
    end

    #
    # Parses the hosts that were found to be down during the scan.
    #
    # @yield [host]
    #   Each host will be passed to a given block.
    #
    # @yieldparam [Host] host
    #   A down host in the scan.
    #
    # @return [XML, Enumerator]
    #   The XML parser. If no block was given, an enumerator object will
    #   be returned.
    #
    # @since 0.8.0
    #
    def each_down_host
      return enum_for(__method__) unless block_given?

      @doc.xpath("/nmaprun/host[status[@state='down']]").each do |host|
        yield Host.new(host)
      end

      return self
    end

    #
    # Parses the hosts found to be down during the scan.
    #
    # @return [Array<Host>]
    #   The down hosts in the scan.
    #
    # @since 0.8.0
    #
    def down_hosts
      each_down_host.to_a
    end

    #
    # Returns the first host found to be down during the scan.
    #
    # @return [Host]
    #
    # @since 0.8.0
    #
    def down_host
      each_down_host.first
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
    # @return [XML, Enumerator]
    #   The XML parser. If no block was given, an enumerator object will
    #   be returned.
    #
    def each_up_host
      return enum_for(__method__) unless block_given?

      @doc.xpath("/nmaprun/host[status[@state='up']]").each do |host|
        yield Host.new(host)
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
      each_up_host.to_a
    end

    #
    # Returns the first host found to be up during the scan.
    #
    # @return [Host]
    #
    # @since 0.8.0
    #
    def up_host
      each_up_host.first
    end

    #
    # Parses the hosts that were found to be up during the scan.
    #
    # @see each_up_host
    #
    def each(&block)
      each_up_host(&block)
    end

    #
    # Converts the XML parser to a String.
    #
    # @return [String]
    #   The path of the XML file or the raw XML.
    #
    def to_s
      if @path then @path.to_s
      else          @doc.to_s
      end
    end

  end
end
