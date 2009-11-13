require 'nmap/status'
require 'nmap/address'
require 'nmap/os'
require 'nmap/port'

require 'nokogiri'
require 'enumerator'

module Nmap
  class Host

    include Enumerable

    #
    # Creates a new Host object.
    #
    # @param [Nokogiri::XML::Node] node
    #   The XML node that contains the host information.
    #
    # @yield [host]
    #   If a block is given, it will be passed the newly created Host
    #   object.
    #
    # @yieldparam [Host] host
    #   The newly created Host object.
    #
    def initialize(node,&block)
      @node = node

      block.call(self) if block
    end

    #
    # Parses the status of the host.
    #
    # @return [Status]
    #   The status of the host.
    #
    def status
      status = @node.at('status')

      return Status.new(
        status['state'].to_sym,
        status['reason']
      )
    end

    #
    # Parses each address of the host.
    #
    # @yield [addr]
    #   Each parsed address will be pass to a given block.
    #
    # @yieldparam [Address] addr
    #   A address of the host.
    #
    # @return [Host]
    #   The host.
    #
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

    #
    # Parses the addresses of the host.
    #
    # @return [Array<Host>]
    #   The addresses of the host.
    #
    def addresses
      Enumerator.new(self,:each_address).to_a
    end

    #
    # Parses the MAC address of the host.
    #
    # @return [String]
    #   The MAC address of the host.
    #
    def mac
      unless @mac
        addr = @node.xpath("address[@addr][@addrtype='mac']").first

        @mac = addr['addr'] if addr
      end

      return @mac
    end

    #
    # Parses the IPv4 address of the host.
    #
    # @return [String]
    #   The IPv4 address of the host.
    #
    def ipv4
      unless @ipv4
        addr = @node.xpath("address[@addr][@addrtype='ipv4']").first

        @ipv4 = addr['addr'] if addr
      end

      return @ipv4
    end

    #
    # Parses the IPv6 address of the host.
    #
    # @return [String]
    #   The IPv6 address of the host.
    #
    def ipv6
      unless @ipv6
        addr = @node.xpath("address[@addr][@addrtype='ipv6']").first

        @ipv6 = addr['addr'] if addr
      end

      return @ipv6
    end

    #
    # The IP address of the host.
    #
    # @return [String]
    #   The IPv4 or IPv6 address of the host.
    #
    def ip
      ipv6 || ipv4
    end

    #
    # The address of the host.
    #
    # @return [String]
    #   The IP or MAC address of the host.
    #
    def address
      ip || mac
    end

    #
    # Parses the hostnames of the host.
    #
    # @yield [host]
    #   Each parsed hostname will be passed to the given block.
    #
    # @yieldparam [String] host
    #   A hostname of the host.
    #
    # @return [Host]
    #   The host.
    #
    def each_hostname(&block)
      @node.xpath("hostnames/hostname[@name]").each do |host|
        block.call(host['name']) if block
      end

      return self
    end

    #
    # Parses the hostnames of the host.
    #
    # @return [Array<String>]
    #   The hostnames of the host.
    #
    def hostnames
      Enumerator.new(self,:each_hostname).to_a
    end

    #
    # Parses the OS guessing information of the host.
    #
    # @yield [os]
    #   If a block is given, it will be passed the OS guessing information.
    #
    # @yieldparam [OS] os
    #   The OS guessing information.
    #
    # @return [OS]
    #   The OS guessing information.
    #
    def os(&block)
      os = @node.at('os')

      return OS.new(os,&block) if os
    end

    #
    # Parses the scanned ports of the host.
    #
    # @yield [port]
    #   Each scanned port of the host.
    #
    # @yieldparam [Port] port
    #   A scanned port of the host.
    #
    # @return [Host]
    #   The host.
    #
    def each_port(&block)
      @node.xpath("ports/port").each do |port|
        block.call(create_port(port)) if block
      end

      return self
    end

    #
    # Parses the scanned ports of the host.
    #
    # @return [Array<Port>]
    #   The scanned ports of the host.
    #
    def ports
      Enumerator.new(self,:each_port).to_a
    end

    #
    # Parses the open ports of the host.
    #
    # @yield [port]
    #   Each open port of the host.
    #
    # @yieldparam [Port] port
    #   An open scanned port of the host.
    #
    # @return [Host]
    #   The host.
    #
    def each_open_port(&block)
      @node.xpath("ports/port[state/@state='open']").each do |port|
        block.call(create_port(port)) if block
      end

      return self
    end

    #
    # Parses the open ports of the host.
    #
    # @return [Array<Port>]
    #   The open ports of the host.
    #
    def open_ports
      Enumerator.new(self,:each_open_port).to_a
    end

    #
    # Parses the TCP ports of the host.
    #
    # @yield [port]
    #   Each TCP port of the host.
    #
    # @yieldparam [Port] port
    #   An TCP scanned port of the host.
    #
    # @return [Host]
    #   The host.
    #
    def each_tcp_port(&block)
      @node.xpath("ports/port[@protocol='tcp']").each do |port|
        block.call(create_port(port)) if block
      end

      return self
    end

    #
    # Parses the TCP ports of the host.
    #
    # @return [Array<Port>]
    #   The TCP ports of the host.
    #
    def tcp_ports
      Enumerator.new(self,:each_tcp_port).to_a
    end

    #
    # Parses the UDP ports of the host.
    #
    # @yield [port]
    #   Each UDP port of the host.
    #
    # @yieldparam [Port] port
    #   An UDP scanned port of the host.
    #
    # @return [Host]
    #   The host.
    #
    def each_udp_port(&block)
      @node.xpath("ports/port[@protocol='udp']").each do |port|
        block.call(create_port(port)) if block
      end

      return self
    end

    #
    # Parses the UDP ports of the host.
    #
    # @return [Array<Port>]
    #   The UDP ports of the host.
    #
    def udp_ports
      Enumerator.new(self,:each_udp_port).to_a
    end

    #
    # Parses the open ports of the host.
    #
    # @see each_open_port
    #
    def each(&block)
      each_open_port(&block)
    end

    #
    # Converts the host to a String.
    #
    # @return [String]
    #   The address of the host.
    #
    # @see address
    #
    def to_s
      address.to_s
    end

    protected

    #
    # Creates a new Port object around a node.
    #
    # @param [Nokogiri::XML::Node] node
    #   The node to create the Port object around.
    #
    # @return [Port]
    #   The port object.
    #
    def create_port(node)
      state = node.at('state')

      if (service = node.at('service/@name'))
        service = service.inner_text
      end

      return Port.new(
        node['protocol'].to_sym,
        node['portid'].to_i,
        state['state'].to_sym,
        state['reason'],
        service
      )
    end

  end
end
