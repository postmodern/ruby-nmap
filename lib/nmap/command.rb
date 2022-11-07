require 'command_mapper/command'

module Nmap
  #
  # ## Nmap options:
  #
  # ### Target Specifications:
  #
  # * `-iL` - `nmap.target_file`
  # * `-iR` - `nmap.random_targets`
  # * `--exclude` - `nmap.exclude`
  # * `--excludefile` - `nmap.exclude_file`
  #
  # ### Host Discovery:
  #
  # * `-sL` - `nmap.list`
  # * `-sn` - `nmap.ping`
  # * `-Pn` - `nmap.skip_discovery`
  # * `-PS` - `nmap.syn_discovery`
  # * `-PA` - `nmap.ack_discovery`
  # * `-PU` - `nmap.udp_discovery`
  # * '-PY' - `nmap.sctp_init_ping`
  # * `-PE` - `nmap.icmp_echo_discovery`
  # * `-PP` - `nmap.icmp_timestamp_discovery`
  # * `-PM` - `nmap.icmp_netmask_discovery`
  # * `-PO` - `nmap.ip_ping`
  # * `-PR` - `nmap.arp_ping`
  # * `--traceroute` - `nmap.traceroute`
  # * `-n` - `nmap.disable_dns`
  # * `-R` - `nmap.enable_dns`
  # * `--resolve-all` - `nmap.resolve_all`
  # * `--unique` - `nmap.unique`
  # * `--systems-dns` - `nmap.systems_dns`
  # * `--dns-servers` - `nmap.dns_servers`
  #
  # ### Port Scanning Techniques:
  #
  # * `-sS` - `nmap.syn_scan`
  # * `-sT` - `nmap.connect_scan`
  # * `-sU` - `nmap.udp_scan`
  # * `-sY` - `nmap.sctp_init_scan`
  # * `-sN` - `nmap.null_scan`
  # * `-sF` - `nmap.fin_scan`
  # * `-sX` - `nmap.xmas_scan`
  # * `-sA` - `nmap.ack_scan`
  # * `-sW` - `nmap.window_scan`
  # * `-sM` - `nmap.maimon_scan`
  # * `--scanflags` - `nmap.tcp_scan_flags`
  # * `-sZ` - `nmap.sctp_cookie_echo_scan`
  # * `-sI` - `nmap.idle_scan`
  # * `-sO` - `nmap.ip_scan`
  # * `-b` - `nmap.ftp_bounce_scan`
  #
  # ### Port Specification and Scan Order:
  #
  # * `-p` - `nmap.ports`
  # * `--exclude-ports` - `nmap.exclude_ports`
  # * `-F` - `nmap.fast`
  # * `-r` - `nmap.consecutively`
  # * `--top-ports` - `nmap.top_ports`
  # * `--port-ratio` - `nmap.port_ratio`
  #
  # ### Service/Version Detection:
  #
  # * `-sV` - `nmap.service_scan`
  # * `--allports` - `nmap.all_ports`
  # * `--version-intensity` - `nmap.version_intensity`
  # * `--version-light` - `nmap.version_light`
  # * `--version-all` - `nmap.version_all`
  # * `--version-trace` - `nmap.version_trace`
  # * `-sR` - `nmap.rpc_scan`
  #
  # ### Script Scan:
  #
  # * `-sC` - `nmap.default_script`
  # * `--script` - `nmap.script`
  # * `--script-args` - `nmap.script_args`
  # * `--script-args-file` - `nmap.script_args_file`
  # * `--script-help` - `nmap.script_help`
  # * `--script-trace` - `nmap.script_trace`
  # * `--script-updatedb` - `nmap.update_scriptdb`
  #
  # ### OS Detection:
  #
  # * `-O` - `nmap.os_fingerprint`
  # * `--osscan-limit` - `nmap.limit_os_scan`
  # * `--osscan-guess` - `nmap.max_os_scan`
  #
  # ### Timing and Performance:
  #
  # * `--min-hostgroup` - `nmap.min_host_group`
  # * `--max-hostgroup` - `nmap.max_host_group`
  # * `--min-parallelism` - `nmap.min_parallelism`
  # * `--max-parallelism` - `nmap.max_parallelism`
  # * `--min-rtt-timeout` - `nmap.min_rtt_timeout`
  # * `--max-rtt-timeout` - `nmap.max_rtt_timeout`
  # * `--initial-rtt-timeout` - `nmap.initial_rtt_timeout`
  # * `--max-retries` - `nmap.max_retries`
  # * `--host-timeout` - `nmap.host_timeout`
  # * `--script-timeout` - `nmap.script_timeout`
  # * `--scan-delay` - `nmap.scan_delay`
  # * `--max-scan-delay` - `nmap.max_scan_delay`
  # * `--min-rate` - `nmap.min_rate`
  # * `--max-rate` - `nmap.max_rate`
  # * `--defeat-rst-ratelimit` - `nmap.defeat_rst_ratelimit`
  # * `--defeat-icmp-ratelimit` - `nmap.defeat_icmp_ratelimit`
  # * `--nsock-engine` - `nmap.nsock_engine`
  # * `-T` - `nmap.timing_template`
  # * `-T0` - `nmap.paranoid_timing`
  # * `-T1` - `nmap.sneaky_timing`
  # * `-T2` - `nmap.polite_timing`
  # * `-T3` - `nmap.normal_timing`
  # * `-T4` - `nmap.aggressive_timing`
  # * `-T5` - `nmap.insane_timing`
  #
  # ### Firewall/IDS Evasion and Spoofing:
  #
  # * `-f` - `nmap.packet_fragments`
  # * `--mtu` - `nmap.mtu`
  # * `-D` - `nmap.decoys`
  # * `-S` - `nmap.spoof`
  # * `-e` - `nmap.interface`
  # * `-g` - `nmap.source_port`
  # * `--proxies` - `nmap.proxies`
  # * `--data` - `nmap.data`
  # * `--data-string` - `nmap.data_string`
  # * `--data-length` - `nmap.data_length`
  # * `--ip-options` - `nmap.ip_options`
  # * `--ttl` - `nmap.ttl`
  # * `--randomize-hosts` - `nmap.randomize_hosts`
  # * `--spoof-mac` - `nmap.spoof_mac`
  # * `--badsum` - `nmap.bad_checksum`
  # * `--adler32` - `nmap.sctp_adler32`
  #
  # ### Output:
  #
  # * `-oN` - `nmap.save`
  # * `-oX` - `nmap.xml`
  # * `-oS` - `nmap.skiddie`
  # * `-oG` - `nmap.grepable`
  # * `-oA` - `nmap.output_all`
  #
  # ### Verbosity and Debugging:
  #
  # * `-v` - `nmap.verbose`
  # * `-v0` - `nmap.quiet`
  # * `-d` - `nmap.debug`
  # * `--reason` - `nmap.show_reason`
  # * `--stats-every` - `nmap.stats_every`
  # * `--packet-trace` - `nmap.show_packets`
  # * `--open` - `nmap.show_open_ports`
  # * `--iflist` - `nmap.show_interfaces`
  # * `--log-errors` - `nmap.show_log_errors`
  #
  # ### Miscellaneous Output:
  #
  # * `--append-output` - `nmap.append`
  # * `--resume` - `nmap.resume`
  # * `--stylesheet` - `nmap.stylesheet`
  # * `--webxml` - `nmap.nmap_stylesheet`
  # * `--no-stylesheet` - `nmap.disable_stylesheet`
  #
  # ### Misc:
  #
  # * `-6` - `nmap.ipv6`
  # * `-A` - `nmap.all`
  # * `--datadir` - `nmap.nmap_datadir`
  # * `--servicedb` - `nmap.servicedb`
  # * `--versiondb` - `nmap.versiondb`
  # * `--send-eth` - `nmap.raw_ethernet`
  # * `--send-ip` - `nmap.raw_ip`
  # * `--privileged` - `nmap.privileged`
  # * `--unprivileged` - `nmap.unprivileged`
  # * `--release-memory` - `nmap.release_memory`
  # * `--noninteractive` - `nmap.non_interactive`
  # * `-V` - `nmap.version`
  # * `-h` - `nmap.help`
  #
  # * `target specification` - `nmap.targets`
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
      option '--scanflags', name: :tcp_scan_flags, value: true
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
      option '-g', name: :source_port, value: {type: Num.new(range: 0..65535)}
      option '--proxies', value: {type: List.new}
      option '--data', value: true
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
      option '-oG', name: :grepable, value: true
      option '-oA', name: :output_all, value: true

      # Verbosity and Debugging:
      option '-v', name: :verbose
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
      option '--append-output', name: :append
      option '--resume', value: true
      option '--stylesheet', value: true
      option '--webxml', name: :nmap_stylesheet
      option '--no-stylesheet', name: :disable_stylesheet

      # MISC:
      option '-6', name: :ipv6
      option '-A', name: :all
      option '--datadir', name: :nmap_datadir, value: {type: InputDir.new}
      option '--servicedb', value: {type: InputFile.new}
      option '--versiondb', value: {type: InputFile.new}
      option '--send-eth', name: :raw_ethernet
      option '--send-ip', name: :raw_ip
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
