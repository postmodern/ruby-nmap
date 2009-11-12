require 'nmap/status'
require 'nmap/address'
require 'nmap/os'
require 'nmap/port'

require 'nokogiri'
require 'enumerator'

module Nmap
  class Host

    include Enumerable

    def initialize(node)
      @node = node
    end

    def status
      status = @node.at('status')

      return Status.new(
        status['state'].to_sym,
        status['reason']
      )
    end

    def each_address(&block)
      @node.xpath("address[@addr]").each do |addr|
        address = Address.new(
          addr['addrtype'].to_sym,
          addr['addr']
        )

        block.call(address) if block
      end

      return self
    end

    def addresses
      Enumerator.new(self,:each_address).to_a
    end

    def mac
      unless @mac
        addr = @node.xpath("address[@addr][@addrtype='mac']").first

        @mac = addr['addr'] if addr
      end

      return @mac
    end

    def ipv4
      unless @ipv4
        addr = @node.xpath("address[@addr][@addrtype='ipv4']").first

        @ipv4 = addr['addr'] if addr
      end

      return @ipv4
    end

    def ipv6
      unless @ipv6
        addr = @node.xpath("address[@addr][@addrtype='ipv6']").first

        @ipv6 = addr['addr'] if addr
      end

      return @ipv6
    end

    def ip
      ipv6 || ipv4
    end

    def address
      ip || mac
    end

    def each_hostname(&block)
      @node.xpath("hostnames/hostname[@name]").each do |host|
        block.call(host['name']) if block
      end

      return self
    end

    def hostnames
      Enumerator.new(self,:each_hostname).to_a
    end

    def os
      os = @node.at('os')

      return OS.new(os) if os
    end

    def each_port(&block)
      @node.xpath("ports/port").each do |port|
        block.call(create_port(port)) if block
      end

      return self
    end

    def ports
      Enumerator.new(self,:each_port).to_a
    end

    def each_open_port(&block)
      @node.xpath("ports/port[state/@state='open']").each do |port|
        block.call(create_port(port)) if block
      end

      return self
    end

    def open_ports
      Enumerator.new(self,:each_open_port).to_a
    end

    def each_tcp_port(&block)
      @node.xpath("ports/port[@protocol='tcp']").each do |port|
        block.call(create_port(port)) if block
      end

      return self
    end

    def tcp_ports
      Enumerator.new(self,:each_tcp_port).to_a
    end

    def each_udp_port(&block)
      @node.xpath("ports/port[@protocol='udp']").each do |port|
        block.call(create_port(port)) if block
      end

      return self
    end

    def udp_ports
      Enumerator.new(self,:each_udp_port).to_a
    end

    def each(&block)
      each_open_port(&block)
    end

    def to_s
      address.to_s
    end

    protected

    def create_port(port)
      state = port.at('state')
      service = port.at('service/@name').inner_text

      return Port.new(
        port['protocol'].to_sym,
        port['portid'].to_i,
        state['state'].to_sym,
        state['reason'],
        service
      )
    end

  end
end
