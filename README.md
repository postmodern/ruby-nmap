# ruby-nmap

[![CI](https://github.com/postmodern/ruby-nmap/actions/workflows/ruby.yml/badge.svg)](https://github.com/postmodern/ruby-nmap/actions/workflows/ruby.yml)
[![Code Climate](https://codeclimate.com/github/postmodern/ruby-nmap.svg)](https://codeclimate.com/github/postmodern/ruby-nmap)
[![Gem Version](https://badge.fury.io/rb/ruby-nmap.svg)](https://badge.fury.io/rb/ruby-nmap)

* [Source](https://github.com/postmodern/ruby-nmap/)
* [Issues](https://github.com/postmodern/ruby-nmap/issues)
* [Documentation](http://rubydoc.info/gems/ruby-nmap/frames)

## Description

A Ruby interface to [nmap], the exploration tool and security / port scanner.
Allows automating nmap and parsing nmap XML files.

## Features

* Provides a Ruby interface for running nmap.
* Provides a Parser for enumerating nmap XML scan files.
* Supports the full [Nmap XML DTD][nmap-dtd].

## Examples

Run Nmap from Ruby:

```ruby
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
```

Run `sudo nmap` from Ruby:

```ruby
require 'nmap/program'

Nmap::Program.sudo_scan do |nmap|
  nmap.syn_scan = true
  # ...
end
```

Parse Nmap XML scan files:

```ruby
require 'nmap/xml'

Nmap::XML.new('scan.xml') do |xml|
  xml.each_host do |host|
    puts "[#{host.ip}]"

    host.each_port do |port|
      puts "  #{port.number}/#{port.protocol}\t#{port.state}\t#{port.service}"
    end
  end
end
```

Print NSE script output from an XML scan file:

```ruby
require 'nmap/xml'

Nmap::XML.new('nse.xml') do |xml|
  xml.each_host do |host|
    puts "[#{host.ip}]"

    host.scripts.each do |name,output|
      output.each_line { |line| puts "  #{line}" }
    end

    host.each_port do |port|
      puts "  [#{port.number}/#{port.protocol}]"

      port.scripts.each do |id,script|
        puts "    [#{id}]"

        script.output.each_line { |line| puts "      #{line}" }
      end
    end
  end
end
```

## Requirements

* [ruby] >= 2.0.0
* [nmap] >= 5.00
* [nokogiri] ~> 1.3
* [command_mapper] ~> 0.2, >= 0.2.1

## Install

```shell
$ gem install ruby-nmap
```

## License

Copyright (c) 2009-2021 Postmodern

See {file:LICENSE.txt} for license information.

[nmap]: http://www.insecure.org/
[ruby]: https://www.ruby-lang.org/
[nokogiri]: http://nokogiri.rubyforge.org/
[command_mapper]: https://github.com/postmodern/command_mapper.rb#readme
[nmap-dtd]: https://nmap.org/book/nmap-dtd.html
