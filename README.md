# ruby-nmap

* [github.com/sophsec/ruby-nmap](http://github.com/sophsec/ruby-nmap/)
* [github.com/sophsec/ruby-nmap/issues](http://github.com/sophsec/ruby-nmap/issues)
* Postmodern (postmodern.mod3 at gmail.com)

## Description

A Ruby interface to Nmap, the exploration tool and security / port scanner.

## Features

* Provides a Ruby interface for running Nmap.
* Provides a Parser for enumerating Nmap XML scan files.

## Examples

Run Nmap from Ruby:

    require 'nmap/program'
    
    Nmap::Program.scan do |nmap|
      nmap.sudo = true

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

## Requirements

* [nmap](http://www.insecure.org/)
* [nokogiri](http://nokogiri.rubyforge.org/) >= 1.3.0
* [rprogram](http://github.com/postmodern/rprogram) ~> 0.2.0

## Install

    $ sudo gem install ruby-nmap

## License

See {file:LICENSE.txt} for license information.

