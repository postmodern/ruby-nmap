# ruby-nmap

* [Source](https://github.com/sophsec/ruby-nmap/)
* [Issues](https://github.com/sophsec/ruby-nmap/issues)
* [Documentation](http://rubydoc.info/gems/ruby-nmap/frames)
* [Email](mailto:postmodern.mod3 at gmail.com)
* [![Build Status](https://travis-ci.org/sophsec/ruby-nmap.svg)](https://travis-ci.org/sophsec/ruby-nmap)

## Description

A Ruby interface to [nmap], the exploration tool and security / port scanner.

## Features

* Provides a Ruby interface for running nmap.
* Provides a Parser for enumerating nmap XML scan files.

## Examples

Run Nmap from Ruby:

    require 'nmap/program'
    
    Nmap::Program.scan do |nmap|
      nmap.syn_scan = true
      nmap.service_scan = true
      nmap.os_fingerprint = true
      nmap.xml = 'scan.xml'
      nmap.verbose = true

      nmap.ports = [20,21,22,23,25,80,110,443,512,522,8080,1080]
      nmap.targets = '192.168.1.*'
    end

Parse Nmap XML scan files:

    require 'nmap/xml'

    Nmap::XML.new('scan.xml') do |xml|
      xml.each_host do |host|
        puts "[#{host.ip}]"
    
        host.each_port do |port|
          puts "  #{port.number}/#{port.protocol}\t#{port.state}\t#{port.service}"
        end
      end
    end

Print NSE script output from an XML scan file:

    require 'nmap/xml'

    Nmap::XML.new('nse.xml') do |xml|
      xml.each_host do |host|
        puts "[#{host.ip}]"

        host.scripts.each do |name,output|
          output.each_line { |line| puts "  #{line}" }
        end

        host.each_port do |port|
          puts "  [#{port.number}/#{port.protocol}]"

          port.scripts.each do |name,output|
            puts "    [#{name}]"

            output.each_line { |line| puts "      #{line}" }
          end
        end
      end
    end

## Requirements

* [ruby] >= 2.0.0
* [nmap] >= 5.00
* [nokogiri] ~> 1.3
* [rprogram] ~> 0.3

## Install

    $ gem install ruby-nmap

## License

Copyright (c) 2009-2014 Postmodern

See {file:LICENSE.txt} for license information.

[nmap]: http://www.insecure.org/
[ruby]: https://www.ruby-lang.org/
[nokogiri]: http://nokogiri.rubyforge.org/
[rprogram]: https://github.com/postmodern/rprogram#readme
