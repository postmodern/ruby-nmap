require 'nmap/status'
require 'nmap/address'
require 'nmap/hostname'
require 'nmap/os'
require 'nmap/port'
require 'nmap/ip_id_sequence'
require 'nmap/tcp_sequence'
require 'nmap/tcp_ts_sequence'
require 'nmap/uptime'
require 'nmap/traceroute'
require 'nmap/host_script'

require 'nokogiri'
require 'time'

module Nmap
  #
  # Wraps a `host` XML element.
  #
  class Host

    include Enumerable

    #
    # Creates a new Host object.
    #
    # @param [Nokogiri::XML::Node] node
    #   The XML node that contains the host information.
    #
    def initialize(node)
      @node = node
    end

    #
    # The time the host was first scanned.
    #
    # @return [Time]
    #   The time the host was first scanned.
    #
    # @since 0.1.2
    #
    def start_time
      @start_time ||= Time.at(@node['starttime'].to_i)
    end

    #
    # The time the host was last scanned.
    #
    # @return [Time]
    #   The time the host was last scanned.
    #
    # @since 0.1.2
    #
    def end_time
      @end_time ||= Time.at(@node['endtime'].to_i)
    end

    #
    # Parses the status of the host.
    #
    # @return [Status]
    #   The status of the host.
    #
    def status
      unless @status
        status = @node.at('status')

        @status = Status.new(
          status['state'].to_sym,
          status['reason']
        )
      end

      return @status
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
    # @return [Host, Enumerator]
    #   The host.
    #   If no block was given, an enumerator will be returned.
    #
    def each_address
      return enum_for(__method__) unless block_given?

      @node.xpath("address[@addr]").each do |addr|
        address = Address.new(
          addr['addrtype'].to_sym,
          addr['addr'],
          addr['vendor']
        )

        yield address
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
      each_address.to_a
    end

    #
    # Parses the MAC address of the host.
    #
    # @return [String]
    #   The MAC address of the host.
    #
    def mac
      @mac ||= if (addr = @node.at("address[@addrtype='mac']"))
                 addr['addr']
               end
    end

    #
    # Parses the MAC vendor of the host.
    #
    # @return [String]
    #   The Mac Vendor of the host.
    #
    # @since 0.8.0
    #
    def vendor
      @vendor ||= if (vendor = @node.at("address/@vendor"))
                 vendor.inner_text
               end
    end

    #
    # Parses the IPv4 address of the host.
    #
    # @return [String]
    #   The IPv4 address of the host.
    #
    def ipv4
      @ipv4 ||= if (addr = @node.at("address[@addrtype='ipv4']"))
                  addr['addr']
                end
    end

    #
    # Parses the IPv6 address of the host.
    #
    # @return [String]
    #   The IPv6 address of the host.
    #
    def ipv6
      @ipv6 ||= if (addr = @node.at("address[@addrtype='ipv6']"))
                  addr['addr']
                end
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
    # @yieldparam [Hostname] host
    #   A hostname of the host.
    #
    # @return [Host, Enumerator]
    #   The host.
    #   If no block was given, an enumerator will be returned.
    #
    def each_hostname
      return enum_for(__method__) unless block_given?

      @node.xpath("hostnames/hostname[@name]").each do |host|
        yield Hostname.new(host['type'],host['name'])
      end

      return self
    end

    #
    # Parses the hostnames of the host.
    #
    # @return [Array<Hostname>]
    #   The hostnames of the host.
    #
    def hostnames
      each_hostname.to_a
    end

    #
    # The primary hostname of the host.
    #
    # @return [Hostname, nil]
    #
    # @since 0.8.0
    #
    def hostname
      each_hostname.first
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
    def os
      @os ||= if (os = @node.at('os'))
                OS.new(os)
              end

      yield @os if (@os && block_given?)
      return @os
    end
      
    #
    # Parses the Uptime analysis of the host.
    #
    # @yield [uptime]
    #   If a block is given, it will be passed the resulting object
    #
    # @yieldparam [Uptime] 
    #   Uptime value.
    #
    # @return [Uptime]
    #   The parsed object.
    #
    # @since 0.7.0
    #
    def uptime
      @uptime ||= if (uptime = @node.at('uptime'))
                    Uptime.new(
                      uptime['seconds'].to_i,
                      Time.parse(uptime['lastboot'])
                    )
                  end

      yield @uptime if (@uptime && block_given?)
      return @uptime
    end

    #
    # Parses the Tcp Sequence number analysis of the host.
    #
    # @yield [sequence]
    #   If a block is given, it will be passed the resulting object
    #
    # @yieldparam [TcpSequence] sequence
    #   Tcp Sequence number analysis.
    #
    # @return [TcpSequence]
    #   The parsed object.
    #
    def tcp_sequence
      @tcp_sequence ||= if (seq = @node.at('tcpsequence'))
                          TcpSequence.new(seq)
                        end

      yield @tcp_sequence if (@tcp_sequence && block_given?)
      return @tcp_sequence
    end

    #
    # @deprecated Use {#tcp_sequence} instead.
    #
    def tcpsequence(&block)
      warn "DEPRECATION: use #{self.class}#tcp_sequence instead"

      tcp_sequence(&block)
    end

    #
    # Parses the IPID sequence number analysis of the host.
    #
    # @yield [ipidsequence]
    #   If a block is given, it will be passed the resulting object
    #
    # @yieldparam [IpIdSequence] ipidsequence
    #   IPID Sequence number analysis.
    #
    # @return [IpIdSequence]
    #   The parsed object.
    #
    def ip_id_sequence
      @ip_id_sequence ||= if (seq = @node.at('ipidsequence'))
                            IpIdSequence.new(seq)
                          end

      yield @ip_id_sequence if (@ip_id_sequence && block_given?)
      return @ip_id_sequence
    end

    #
    # @deprecated Use {#ip_id_sequence} instead.
    #
    def ipidsequence(&block)
      warn "DEPRECATION: use #{self.class}#ip_id_sequence instead"

      ip_id_sequence(&block)
    end

    #
    # Parses the TCP Timestamp sequence number analysis of the host.
    #
    # @yield [tcptssequence]
    #   If a block is given, it will be passed the resulting object
    #
    # @yieldparam [TcpTsSequence] tcptssequence
    #   TCP Timestamp Sequence number analysis.
    #
    # @return [TcpTsSequence]
    #   The parsed object.
    #
    def tcp_ts_sequence
      @tcp_ts_sequence ||= if (seq = @node.at('tcptssequence'))
                             TcpTsSequence.new(seq)
                           end

      yield @tcp_ts_sequence if (@tcp_ts_sequence && block_given?)
      return @tcp_ts_sequence
    end

    #
    # @deprecated Use {#tcp_ts_sequence} instead.
    #
    def tcptssequence(&block)
      warn "DEPRECATION: use #{self.class}#tcp_ts_sequence instead"

      tcp_ts_sequence(&block)
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
    # @return [Host, Enumerator]
    #   The host.
    #   If no block was given, an enumerator will be returned.
    #
    def each_port
      return enum_for(__method__) unless block_given?

      @node.xpath("ports/port").each do |port|
        yield Port.new(port)
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
      each_port.to_a
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
    # @return [Host, Enumerator]
    #   The host.
    #   If no block was given, an enumerator will be returned.
    #
    def each_open_port
      return enum_for(__method__) unless block_given?

      @node.xpath("ports/port[state/@state='open']").each do |port|
        yield Port.new(port)
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
      each_open_port.to_a
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
    # @return [Host, Enumerator]
    #   The host.
    #   If no block was given, an enumerator will be returned.
    #
    def each_tcp_port
      return enum_for(__method__) unless block_given?

      @node.xpath("ports/port[@protocol='tcp']").each do |port|
        yield Port.new(port)
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
      each_tcp_port.to_a
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
    # @return [Host, Enumerator]
    #   The host.
    #   If no block was given, an enumerator will be returned.
    #
    def each_udp_port
      return enum_for(__method__) unless block_given?

      @node.xpath("ports/port[@protocol='udp']").each do |port|
        yield Port.new(port)
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
      each_udp_port.to_a
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
    # The output from the NSE scripts ran against the host.
    #
    # @return [Hash{String => String}]
    #   The NSE script names and output.
    #
    # @since 0.3.0
    #
    # @deprecated Use {#host_script} instead.
    #
    def scripts
      if host_script
        host_script.scripts
      else
        {}
      end
    end

    #
    # The NSE scripts ran against the host.
    #
    # @return [HostScript, nil]
    #   Contains the host script output and data.
    #
    # @since 0.9.0
    #
    def host_script
      @host_script ||= if (hostscript = @node.at('hostscript'))
                         HostScript.new(hostscript)
                       end
    end

    #
    # Parses the traceroute information, if present.
    #
    # @yield [traceroute]
    #   If a block is given, it will be passed the traceroute information.
    #
    # @yieldparam [Traceroute] traceroute
    #   The traceroute information.
    #
    # @return [Traceroute]
    #   The traceroute information.
    #
    # @since 0.7.0
    #
    def traceroute
      @traceroute ||= if (trace = @node.at('trace'))
                        Traceroute.new(trace)
                      end

      yield @traceroute if (@traceroute && block_given?)
      return @traceroute
    end

    #
    # Converts the host to a String.
    #
    # @return [String]
    #   The hostname or address of the host.
    #
    # @see address
    #
    def to_s
      (hostname || address).to_s
    end

    #
    # Inspects the host.
    #
    # @return [String]
    #   The inspected host.
    #
    def inspect
      "#<#{self.class}: #{self}>"
    end

  end
end
