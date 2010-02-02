# ruby-nmap

* http://ruby-nmap.rubyforge.org/
* http://github.com/sophsec/ruby-nmap
* http://github.com/sophsec/ruby-nmap/issues
* Postmodern (postmodern.mod3 at gmail.com)

## DESCRIPTION:

A Ruby interface to Nmap, the exploration tool and security / port scanner.

## FEATURES:

* Provides a Ruby interface for running Nmap.
* Provides a Parser for enumerating Nmap XML scan files.

## EXAMPLES:

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

## REQUIREMENTS:

* [nmap](http://www.insecure.org/)
* [nokogiri](http://nokogiri.rubyforge.org/) >= 1.4.0
* [rprogram](http://rprogram.rubyforge.org/) >= 0.1.8

## INSTALL:

    $ sudo gem install ruby-nmap

## LICENSE:

The MIT License

Copyright (c) 2009-2010 Hal Brodigan

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
