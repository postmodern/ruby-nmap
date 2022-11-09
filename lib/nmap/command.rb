require 'command_mapper/command'

module Nmap
  #
  # ## Nmap options:
  #
  # ### Target Specifications:
  #
  # * `-iL path/to/file` - `nmap.target_file = "path/to/file"`
  # * `-iR 10` - `nmap.random_targets = 10`
  # * `--exclude host1 --exclude host2` - `nmap.exclude = ["host1", "host2"`
  # * `--excludefile path/to/file` - `nmap.exclude_file = "path/to/file"`
  #
  # ### Host Discovery:
  #
  # * `-sL` - `nmap.list = true`
  # * `-sn` - `nmap.ping = true`
  # * `-Pn` - `nmap.skip_discovery = true`
  # * `-PS` - `nmap.syn_discovery = [20..80, 443]`
  # * `-PA` - `nmap.ack_discovery = [20..80, 443]`
  # * `-PU` - `nmap.udp_discovery = [20..80, 443]`
  # * '-PY' - `nmap.sctp_init_ping = [20..80, 443]`
  # * `-PE` - `nmap.icmp_echo_discovery = true`
  # * `-PP` - `nmap.icmp_timestamp_discovery = true`
  # * `-PM` - `nmap.icmp_netmask_discovery = true`
  # * `-PO` - `nmap.ip_ping = [1, 2, 3, 4, ...]`
  # * `-PR` - `nmap.arp_ping = true`
  # * `--traceroute` - `nmap.traceroute = true`
  # * `-n` - `nmap.disable_dns = true`
  # * `-R` - `nmap.enable_dns = true`
  # * `--resolve-all` - `nmap.resolve_all = true`
  # * `--unique` - `nmap.unique = true`
  # * `--dns-servers nameserver1,nameserver2` - `nmap.dns_servers = ["nameserver1", "nameserver2"]`
  # * `--systems-dns` - `nmap.systems_dns = true`
  #
  # ### Port Scanning Techniques:
  #
  # * `-sS` - `nmap.syn_scan = true`
  # * `-sT` - `nmap.connect_scan = true`
  # * `-sU` - `nmap.udp_scan = true`
  # * `-sY` - `nmap.sctp_init_scan = true`
  # * `-sN` - `nmap.null_scan = true`
  # * `-sF` - `nmap.fin_scan = true`
  # * `-sX` - `nmap.xmas_scan = true`
  # * `-sA` - `nmap.ack_scan = true`
  # * `-sW` - `nmap.window_scan = true`
  # * `-sM` - `nmap.maimon_scan = true`
  # * `--scanflags` - `nmap.tcp_scan_flags = {syn: true, ack: true, rst: true}` / `nmap.tcp_scan_flags = [:syn, :ack, :rst]` / `nmap.tcp_scan_flags = 9` / `nmap.tcp_scan_flags = "SYNACKRST"`
  # * `-sZ` - `nmap.sctp_cookie_echo_scan = true`
  # * `-sI zombiehost:probeport` - `nmap.idle_scan = "zombiehost:probeport"`
  # * `-sO` - `nmap.ip_scan = true`
  # * `-b ftp.relay-host.com` - `nmap.ftp_bounce_scan = "ftp.relay-host.com"`
  #
  # ### Port Specification and Scan Order:
  #
  # * `-p 22,80,443,8000-9000` - `nmap.ports = [22, 80, 443, 8000..9000]`
  # * `--exclude-ports 1-20,1024-2000` - `nmap.exclude_ports = [1..20, 1024..2000]`
  # * `-F` - `nmap.fast = true`
  # * `-r` - `nmap.consecutively = true`
  # * `--top-ports 10` - `nmap.top_ports = 10`
  # * `--port-ratio 0.5` - `nmap.port_ratio = 0.5`
  #
  # ### Service/Version Detection:
  #
  # * `-sV` - `nmap.service_scan = true`
  # * `--allports` - `nmap.all_ports = true`
  # * `--version-intensity 9` - `nmap.version_intensity = 9`
  # * `--version-light` - `nmap.version_light = true`
  # * `--version-all` - `nmap.version_all = true`
  # * `--version-trace` - `nmap.version_trace = true`
  # * `-sR` - `nmap.rpc_scan = true`
  #
  # ### Script Scan:
  #
  # * `-sC` - `nmap.default_script = true`
  # * `--script script1,script2,script3` - `nmap.script = ["script1", "script2", "script3"]`
  # * `--script-args=arg1=value,arg2=value2` - `nmap.script_args = {arg1: `value1", arg2: "value2"}`
  # * `--script-args-file path/to/file` - `nmap.script_args_file = "path/to/file"`
  # * `--script-help script1,script2,script3` - `nmap.script_help = ["script1", "script2", "script3"]`
  # * `--script-trace` - `nmap.script_trace = true`
  # * `--script-updatedb` - `nmap.update_scriptdb = treu`
  #
  # ### OS Detection:
  #
  # * `-O` - `nmap.os_fingerprint = true`
  # * `--osscan-limit` - `nmap.limit_os_scan = true`
  # * `--osscan-guess` - `nmap.max_os_scan = true`
  #
  # ### Timing and Performance:
  #
  # * `--min-hostgroup 42` - `nmap.min_host_group = 42`
  # * `--max-hostgroup 42` - `nmap.max_host_group = 42`
  # * `--min-parallelism 42` - `nmap.min_parallelism = 42`
  # * `--max-parallelism 42` - `nmap.max_parallelism = 42`
  # * `--min-rtt-timeout 100ms` - `nmap.min_rtt_timeout = "100ms"`
  # * `--max-rtt-timeout 500ms` - `nmap.max_rtt_timeout = "500ms"`
  # * `--initial-rtt-timeout 100ms` - `nmap.initial_rtt_timeout = "100ms"`
  # * `--max-retries 4` - `nmap.max_retries = 4`
  # * `--host-timeout 10s` - `nmap.host_timeout = "10s"`
  # * `--script-timeout 10s` - `nmap.script_timeout = "10s"`
  # * `--scan-delay 1s` - `nmap.scan_delay = "1s"`
  # * `--max-scan-delay 42s` - `nmap.max_scan_delay = "42s"`
  # * `--min-rate 10` - `nmap.min_rate = 10`
  # * `--max-rate 100` - `nmap.max_rate = 100`
  # * `--defeat-rst-ratelimit` - `nmap.defeat_rst_ratelimit = true`
  # * `--defeat-icmp-ratelimit` - `nmap.defeat_icmp_ratelimit = true`
  # * `--nsock-engine kqueue` - `nmap.nsock_engine = :kqueue`
  # * `-T polite` - `nmap.timing_template = :polite`
  # * `-T0` - `nmap.paranoid_timing = true`
  # * `-T1` - `nmap.sneaky_timing = true`
  # * `-T2` - `nmap.polite_timing = true`
  # * `-T3` - `nmap.normal_timing = true`
  # * `-T4` - `nmap.aggressive_timing = true`
  # * `-T5` - `nmap.insane_timing = true`
  #
  # ### Firewall/IDS Evasion and Spoofing:
  #
  # * `-f` - `nmap.packet_fragments = true`
  # * `--mtu` - `nmap.mtu = true`
  # * `-D decoy1,decoy2` - `nmap.decoys = ["decoy1", "decoy2"]`
  # * `-S 8.8.8.8` - `nmap.spoof = "8.8.8.8"`
  # * `-e eth0` - `nmap.interface = "eth0"`
  # * `-g 1024` - `nmap.source_port = 1024`
  # * `--proxies proxy1,proxy2` - `nmap.proxies = ["proxy1", "proxy2"]`
  # * `--data AABBCCDDEEFF` - `nmap.data = "AABBCCDDEEFF"`
  # * `--data-string foobar` - `nmap.data_string = "foobar"`
  # * `--data-length 42` - `nmap.data_length = 42`
  # * `--ip-options T` - `nmap.ip_options = 'T'`
  # * `--ttl 42` - `nmap.ttl = 42`
  # * `--randomize-hosts` - `nmap.randomize_hosts = true`
  # * `--spoof-mac XX:XX:XX:XX:XX:XX` - `nmap.spoof_mac = "XX:XX:XX:XX:XX:XX"`
  # * `--badsum` - `nmap.bad_checksum = true`
  # * `--adler32` - `nmap.sctp_adler32 = true`
  #
  # ### Output:
  #
  # * `-oN path/to/file` - `nmap.save = "path/to/file"`
  # * `-oX path/to/file` - `nmap.xml = "path/to/file"`
  # * `-oS path/to/file` - `nmap.skiddie = "path/to/file"`
  # * `-oG path/to/file` - `nmap.output_grepable = "path/to/file"`
  # * `-oA path/to/basename` - `nmap.output_all = "path/to/basename"`
  #
  # ### Verbosity and Debugging:
  #
  # * `-v` - `nmap.verbose = true`
  # * `-v3` - `nmap.verbose = 3`
  # * `-vv` - `nmap.extra_verbose = true`
  # * `-v0` - `nmap.quiet = true`
  # * `-d` - `nmap.debug = true`
  # * `-d9` - `nmap.debug = 9`
  # * `--reason` - `nmap.show_reason = true`
  # * `--stats-every 2s` - `nmap.stats_every = "2s"`
  # * `--packet-trace` - `nmap.show_packets = true`
  # * `--open` - `nmap.show_open_ports = true`
  # * `--iflist` - `nmap.show_interfaces = true`
  # * `--log-errors` - `nmap.show_log_errors = true`
  #
  # ### Miscellaneous Output:
  #
  # * `--append-output` - `nmap.append_output = true`
  # * `--resume` - `nmap.resume = true`
  # * `--stylesheet path/to/stylesheet.xsl` - `nmap.stylesheet = "path/to/stylesheet.xsl"`
  # * `--webxml` - `nmap.webxml = true`
  # * `--no-stylesheet` - `nmap.no_stylesheet = true`
  #
  # ### Misc:
  #
  # * `-6` - `nmap.ipv6 = true`
  # * `-A` - `nmap.all = true`
  # * `--datadir path/to/nmap/dir` - `nmap.nmap_datadir = "path/to/nmap/dir"`
  # * `--servicedb path/to/services.txt` - `nmap.servicedb = "path/to/services.txt"`
  # * `--versiondb path/to/versions.txt` - `nmap.versiondb = "path/to/versions.txt"`
  # * `--send-eth` - `nmap.send_eth = true`
  # * `--send-ip` - `nmap.send_ip = true`
  # * `--privileged` - `nmap.privileged = true`
  # * `--unprivileged` - `nmap.unprivileged = true`
  # * `--release-memory` - `nmap.release_memory = true`
  # * `--noninteractive` - `nmap.non_interactive = true`
  # * `-V` - `nmap.version = true`
  # * `-h` - `nmap.help = true`
  #
  # * `google.com 1.1.1.1 192.168.1-2.*` - `nmap.targets = ["google.com", "1.1.1.1", "192.168.1-2.*"]`
  #
  # @see http://nmap.org/book/man.html
  #
  class Command < CommandMapper::Command

    #
    # @api private
    #
    class Port < CommandMapper::Types::Num

      PORT_NUMBER_REGEXP = /\d{1,5}/

      SERVICE_NAME_REGEXP = /[A-Za-z0-9]+(?:[\/_-][A-Za-z0-9]+)*\*?/

      PORT_REGEXP = /(?:#{PORT_NUMBER_REGEXP}|#{SERVICE_NAME_REGEXP})/

      REGEXP = /\A#{PORT_REGEXP}\z/

      #
      # Initializes the port type.
      #
      def initialize
        super(range: 1..65535)
      end

      #
      # Validates the given value.
      #
      # @param [Object] value
      #
      # @return [true, (false, String)]
      #
      def validate(value)
        case value
        when String
          case value
          when /\A#{PORT_NUMBER_REGEXP}\z/
            super(value)
          when /\A#{SERVICE_NAME_REGEXP}\z/
            return true
          else
            return [false, "must be a port number or service name (#{value.inspect})"]
          end
        else
          super(value)
        end
      end

      #
      # Formats the given value.
      #
      # @param [Integer, String] value
      #
      # @return [String]
      #
      def format(value)
        case value
        when String
          value
        else
          super(value)
        end
      end

    end

    #
    # @api private
    #
    class PortRange < Port

      PORT_RANGE_REGEXP = /(?:#{PORT_REGEXP}|#{PORT_REGEXP}?-#{PORT_REGEXP}?)/

      REGEXP = /\A#{PORT_RANGE_REGEXP}\z/

      #
      # Validates the given value.
      #
      # @param [Object] value
      #
      # @return [true, (false, String)]
      #
      def validate(value)
        case value
        when Range
          valid, message = super(value.begin)

          unless valid
            return [valid, message]
          end

          valid, message = super(value.end)

          unless valid
            return [valid, message]
          end

          return true
        when String
          unless value =~ REGEXP
            return [false, "not a valid port range (#{value.inspect})"]
          end

          return true
        else
          super(value)
        end
      end

      #
      # Formats the given value.
      #
      # @param [Range, Integer, String] value
      #
      # @return [String]
      #
      def format(value)
        case value
        when Range
          "#{value.begin}-#{value.end}"
        else
          super(value)
        end
      end

    end

    #
    # @api private
    #
    class PortRangeList < CommandMapper::Types::List

      PORT_RANGE_REGEXP = PortRange::PORT_RANGE_REGEXP

      REGEXP = /\A(?:[TUS]:)?#{PORT_RANGE_REGEXP}(?:,(?:[TUS]:)?#{PORT_RANGE_REGEXP})*\z/

      #
      # Initializes the port range list type.
      #
      def initialize
        super(type: PortRange.new)
      end

      #
      # Validates the given port range list value.
      #
      # @param [Object] value
      #
      # @return [true, (false, String)]
      #
      def validate(value)
        case value
        when Hash
          if value.empty?
            return [false, "cannot be empty"]
          end

          value.each do |protocol,ports|
            unless PROTOCOL_LETTERS.has_key?(protocol)
              return [false, "unknown protocol (#{protocol.inspect}) must be :tcp, :udp, or :sctp"]
            end

            valid, message = validate(ports)

            unless valid
              return [valid, message]
            end
          end

          return true
        when Range
          @type.validate(value)
        when String
          unless value =~ REGEXP
            return [false, "not a valid port range list (#{value.inspect})"]
          end

          return true
        else
          super(value)
        end
      end

      # Mapping of protocol names to single letters used in port range syntax.
      PROTOCOL_LETTERS = {
        tcp:  'T',
        udp:  'U',
        sctp: 'S'
      }

      #
      # Formats the given value.
      #
      # @param [Hash, Range, String, Integer] value
      #
      # @return [String]
      #
      def format(value)
        case value
        when Hash
          # format a hash of protocols and port ranges
          value.map { |protocol,ports|
            letter = PROTOCOL_LETTERS.fetch(protocol)

            "#{letter}:#{format(ports)}"
          }.join(',')
        when Range
          # format an individual port range
          @type.format(value)
        when String
          # pass strings directly through
          value
        else
          super(value)
        end
      end

    end

    #
    # @api private
    #
    ProtocolList = PortRangeList

    #
    # @api private
    #
    class Time < CommandMapper::Types::Str

      REGEXP = /\A\d+(?:h|m|s|ms)?\z/

      #
      # Validates a time value.
      #
      # @param [String, Integer] value
      #   The time value to validate.
      #
      # @return [true, (false, String)]
      #   Returns true if the value is considered valid, or false and a
      #   validation message if the value is not valid.
      #
      def validate(value)
        case value
        when Integer then true
        else
          valid, message = super(value)

          unless valid
            return [valid, message]
          end

          value = value.to_s

          unless value =~ REGEXP
            return [false, "must be a number and end with 'ms', 's', 'm', or 'h'"]
          end

          return true
        end
      end

    end

    #
    # @api private
    #
    class HexString < CommandMapper::Types::Str

      REGEXP = /\A(?:(?:0x)?[0-9A-F]+|(?:\\x[0-9A-F]{2})+)\z/

      #
      # Validates a hex string value.
      #
      # @param [String, #to_s] value
      #   The hex string value to validate.
      #
      # @return [true, (false, String)]
      #   Returns true if the value is considered valid, or false and a
      #   validation message if the value is not valid.
      #
      def validate(value)
        valid, message = super(value)

        unless valid
          return [valid, message]
        end

        value = value.to_s

        unless value =~ REGEXP
          return [false, "must be of the format 0xAABBCCDDEEFF..., AABBCCDDEEFF..., or \\xAA\\xBB\\xCC\\xDD\\xEE\\xFF..."]
        end

        return true
      end

    end

    #
    # @api private
    #
    class ScanFlags < CommandMapper::Types::Str

      FLAGS = {
        urg: 'URG',
        ack: 'ACK',
        psh: 'PSH',
        rst: 'RST',
        syn: 'SYN',
        fin: 'FIN'
      }

      REGEXP = /\A(?:\d+|(?:URG|ACK|PSH|RST|SYN|FIN)+)\z/

      #
      # Validates a scanflags value.
      #
      # @param [String, Hash{Symbol => Boolean}, #to_s] value
      #   The scanflags value to validate.
      #
      # @return [true, (false, String)]
      #   Returns true if the value is considered valid, or false and a
      #   validation message if the value is not valid.
      #
      def validate(value)
        case value
        when Hash
          if value.empty?
            return [false, "Hash value cannot be empty"]
          end

          unless value.keys.all? { |key| FLAGS.has_key?(key) }
            return [false, "Hash must only contain the keys :urg, :ack, :psh, :rst, :syn, or :fin"]
          end

          unless value.values.all? { |value| value == nil || value == false || value == true }
            return [false, "Hash must only contain the values true, false, or nil"]
          end

          return true
        when Array
          if value.empty?
            return [false, "Array value cannot be empty"]
          end

          unless value.all? { |flag| FLAGS.has_key?(flag) }
            return [false, "Array must only contain the values :urg, :ack, :psh, :rst, :syn, or :fin"]
          end

          return true
        else
          valid, message = super(value)

          unless valid
            return [valid, message]
          end

          value = value.to_s

          unless value =~ REGEXP
            return [false, "must only contain URG, ACK, PSH, RST, SYN, or FIN"]
          end

          return true
        end
      end

      #
      # Formats a scanflags value.
      #
      # @param [Hash{Symbol => Boolean}, Array<String>, #to_s] value
      #   The scanflags value to format.
      #
      # @return [String]
      #   The formatted scanflags value.
      #
      def format(value)
        case value
        when Hash
          string = String.new

          value.each do |key,value|
            string << FLAGS[key] if value
          end

          return string
        when Array
          string = String.new

          value.each do |flag|
            string << FLAGS[flag]
          end

          return string
        else
          super(value)
        end
      end

    end

    command 'nmap' do
      # TARGET SPECIFICATIONS:
      option '-iL', name: :target_file, value: {type: InputFile.new}
      option '-iR', name: :random_targets, value: {type: Num.new}
      option '--exclude', name: :exclude, value: {type: List.new}
      option '--excludefile', name: :exclude_file, value: {type: InputFile.new}

      # HOST DISCOVERY:
      option '-sL', name: :list
      option '-sn', name: :ping
      option '-Pn', name: :skip_discovery
      option '-PS', name: :syn_discovery,
                    value_in_flag: true,
                    value: {type: PortRangeList.new, required: false}
      option '-PA', name: :ack_discovery,
                    value_in_flag: true,
                    value: {type: PortRangeList.new, required: false}
      option '-PU', name: :udp_discovery,
                    value_in_flag: true,
                    value: {type: PortRangeList.new, required: false}
      option '-PY', name: :sctp_init_ping,
                    value_in_flag: true,
                    value: {type: PortRangeList.new, required: false}
      option '-PE', name: :icmp_echo_discovery
      option '-PP', name: :icmp_timestamp_discovery
      option '-PM', name: :icmp_netmask_discovery
      option '-PO', name: :ip_ping,
                    value_in_flag: true,
                    value: {type: ProtocolList.new, required: false}
      option '-PR', name: :arp_ping
      option '--traceroute', name: :traceroute
      option '-n', name: :disable_dns
      option '-R', name: :enable_dns
      option '--resolve-all'
      option '--unique'
      option '--dns-servers', value: {type: List.new}
      option '--system-dns'

      # PORT SCANNING TECHNIQUES:
      option '-sS', name: :syn_scan
      option '-sT', name: :connect_scan
      option '-sU', name: :udp_scan
      option '-sY', name: :sctp_init_scan
      option '-sN', name: :null_scan
      option '-sF', name: :fin_scan
      option '-sX', name: :xmas_scan
      option '-sA', name: :ack_scan
      option '-sW', name: :window_scan
      option '-sM', name: :maimon_scan
      option '--scanflags', name: :tcp_scan_flags, value: {type: ScanFlags.new}
      option '-sZ', name: :sctp_cookie_echo_scan
      option '-sI', name: :idle_scan, value: true
      option '-sO', name: :ip_scan
      option '-b', name: :ftp_bounce_scan, value: true

      # PORT SPECIFICATION AND SCAN ORDER:
      option '-p', name: :ports, value: {type: PortRangeList.new}
      option '--exclude-ports', value: {type: PortRangeList.new}
      option '-F', name: :fast
      option '-r', name: :consecutively
      option '--top-ports', value: {type: Num.new}
      option '--port-ratio', value: {type: Dec.new(range: 0.0..1.0)}

      # SERVICE/VERSION DETECTION:
      option '-sV', name: :service_scan
      option '--allports', name: :all_ports
      option '--version-intensity', value: {type: Num.new(range: 0..9)}
      option '--version-light'
      option '--version-all'
      option '--version-trace'
      option '-sR', name: :rpc_scan

      # SCRIPT SCAN:
      option '-sC', name: :default_script
      option '--script', value: {type: List.new}
      option '--script-args', value: {type: KeyValueList.new}
      option '--script-args-file', value: {type: InputFile.new}
      option '--script-help', value: {type: List.new}
      option '--script-trace'
      option '--script-updatedb', name: :update_scriptdb

      # OS DETECTION:
      option '-O', name: :os_fingerprint
      option '--osscan-limit', name: :limit_os_scan
      option '--osscan-guess', name: :max_os_scan
      option '--max-os-tries', name: :max_os_tries

      # TIMING AND PERFORMANCE:
      option '--min-hostgroup', name: :min_host_group, value: {type: Num.new}
      option '--max-hostgroup', name: :max_host_group, value: {type: Num.new}
      option '--min-parallelism', value: {type: Num.new}
      option '--max-parallelism', value: {type: Num.new}
      option '--min-rtt-timeout', value: {type: Time.new}
      option '--max-rtt-timeout', value: {type: Time.new}
      option '--initial-rtt-timeout', value: {type: Time.new}
      option '--max-retries', value: {type: Num.new}
      option '--host-timeout', value: {type: Time.new}
      option '--script-timeout', value: {type: Time.new}
      option '--scan-delay', value: {type: Time.new}
      option '--max-scan-delay', value: {type: Time.new}
      option '--min-rate', value: {type: Num.new}
      option '--max-rate', value: {type: Num.new}
      option '--defeat-rst-ratelimit'
      option '--defeat-icmp-ratelimit'
      option '--nsock-engine', value: {type: Enum[:iocp, :epoll, :kqueue, :poll, :select]}
      option '-T', name: :timing_template,
                   value: {type: Enum[:paranoid, :sneaky, :polite, :normal, :aggressive, :insane]}
      option '-T0', name: :paranoid_timing
      option '-T1', name: :sneaky_timing
      option '-T2', name: :polite_timing
      option '-T3', name: :normal_timing
      option '-T4', name: :aggressive_timing
      option '-T5', name: :insane_timing

      # FIREWALL/IDS EVASION AND SPOOFING:
      option '-f', name: :packet_fragments
      option '--mtu'
      option '-D', name: :decoys, value: {type: List.new}
      option '-S', name: :spoof, value: true
      option '-e', name: :interface, value: true
      option '-g', name: :source_port, value: {type: Port.new}
      option '--proxies', value: {type: List.new}
      option '--data', value: {type: HexString.new}
      option '--data-string', value: true
      option '--data-length', value: {type: Num.new}
      option '--ip-options', value: true
      option '--ttl', value: {type: Num.new}
      option '--randomize-hosts'
      option '--spoof-mac', value: true
      option '--badsum', name: :bad_checksum
      option '--adler32', name: :sctp_adler32

      # OUTPUT:
      option '-oN', name: :save, value: true
      option '-oX', name: :xml, value: true
      option '-oS', name: :skiddie, value: true
      option '-oG', name: :output_grepable, value: true
      option '-oA', name: :output_all, value: true

      # Verbosity and Debugging:
      option '-v', name: :verbose,
                   value_in_flag: true,
                   value: {type: Num.new, required: false}
      option '-vv', name: :extra_verbose
      option '-v0', name: :quiet
      option '-d', name: :debug,
                   value_in_flag: true,
                   value: {type: Num.new, required: false}
      option '--reason', name: :show_reason
      option '--stats-every', value: {type: Time.new}
      option '--packet-trace', name: :show_packets
      option '--open', name: :show_open_ports
      option '--iflist', name: :show_interfaces
      option '--log-errors', name: :show_log_errors

      # Miscellaneous output:
      option '--append-output'
      option '--resume', value: true
      option '--stylesheet', value: true
      option '--webxml', name: :nmap_stylesheet
      option '--no-stylesheet'

      # MISC:
      option '-6', name: :ipv6
      option '-A', name: :all
      option '--datadir', name: :nmap_datadir, value: {type: InputDir.new}
      option '--servicedb', value: {type: InputFile.new}
      option '--versiondb', value: {type: InputFile.new}
      option '--send-eth'
      option '--send-ip'
      option '--privileged'
      option '--unprivleged'
      option '--release-memory'
      option '--noninteractive', name: :non_interactive
      option '-V', name: :version
      option '-h', name: :help

      argument :targets, required: false, repeats: true
    end

  end
end
