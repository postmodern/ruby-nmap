require 'nmap/host'
require 'nmap/scanner'
require 'nmap/scan'

require 'nokogiri'
require 'enumerator'

module Nmap
  class XML

    include Enumerable

    # Path of the Nmap XML file
    attr_reader :path

    def initialize(path)
      @path = File.expand_path(path)
      @doc = Nokogiri::XML(File.new(@path))
    end

    def scanner
      @scanner ||= Scanner.new(
        @doc.root['scanner'],
        @doc.root['version'],
        @doc.root['args']
      )
    end

    def version
      @version ||= @doc.root['xmloutputversion']
    end

    def scan_info
      @doc.xpath("/nmaprun/scaninfo").map do |scaninfo|
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

    def verbose
      @verbose ||= @doc.at("verbose/@level").inner_text.to_i
    end

    def debugging
      @debugging ||= @doc.at("debugging/@level").inner_text.to_i
    end

    def each_host(&block)
      @doc.xpath("/nmaprun/host").each do |host|
        block.call(Host.new(host)) if block
      end

      return self
    end

    def hosts
      Enumerator.new(self,:each_host).to_a
    end

    def each_up_host(&block)
      @doc.xpath("/nmaprun/host[status[@state='up']]").each do |host|
        block.call(Host.new(host)) if block
      end

      return self
    end

    def up_hosts
      Enumerator.new(self,:each_up_host).to_a
    end

    def each(&block)
      each_up_hosts(&block)
    end

    def to_s
      @path.to_s
    end

  end
end
