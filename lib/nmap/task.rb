require 'rprogram/task'

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
  # * `-sP` - `nmap.ping`
  # * `-PN` - `nmap.skip_discovery`
  # * `-PS` - `nmap.syn_discovery`
  # * `-PA` - `nmap.ack_discovery`
  # * `-PU` - `nmap.udp_discovery`
  # * `-PE` - `nmap.icmp_echo_discovery`
  # * `-PP` - `nmap.icmp_timestamp_discovery`
  # * `-PM` - `nmap.icmp_netmask_discovery`
  # * `-PO` - `nmap.ip_ping`
  # * `-n` - `nmap.disable_dns`
  # * `-R` - `nmap.enable_dns`
  # * `--dns-servers` - `nmap.dns_servers`
  # * `--systems-dns` - `nmap.systems_dns`
  #
  # ### Scan Techniques:
  #
  # * `-sS` - `nmap.syn_scan`
  # * `-sT` - `nmap.connect_scan`
  # * `-sA` - `nmap.ack_scan`
  # * `-sW` - `nmap.window_scan`
  # * `-sM` - `nmap.maimon_scan`
  # * `-sU` - `nmap.udp_scan`
  # * `-sN` - `nmap.null_scan`
  # * `-sF` - `nmap.fin_scan`
  # * `-sX` - `nmap.xmas_scan`
  # * `--scanflags` - `nmap.tcp_scan_flags`
  # * `-sI` - `nmap.idle_scan`
  # * `-s0` - `nmap.ip_scan`
  # * `-b` - `nmap.ftp_bounce_scan`
  # * `--traceroute` - `nmap.traceroute`
  # * `--reason` - `nmap.show_reason`
  #
  # ### Port Specification and Scan Order:
  #
  # * `-p` - `nmap.ports`
  # * `-F` - `nmap.fast`
  # * `-r` - `nmap.consecutively`
  # * `--top-ports` - `nmap.top_ports`
  # * `--port-ratio` - `nmap.port_ratio`
  #
  # ### Service/Version Detection:
  #
  # * `-sV` - `nmap.service_scan`
  # * `--version-intensity` - `nmap.version_intensity`
  # * `--version-light` - `nmap.version_light`
  # * `--version-all` - `nmap.version_all`
  # * `--version-trace` - `nmap.version_trace`
  #
  # ### Script Scan:
  #
  # * `-sC` - `nmap.default_script`
  # * `--script` - `nmap.script`
  # * `--script-args` - `nmap.script_params`
  # * `--script-trace` - `nmap.script_trace`
  # * `--script-updatedb` - `nmap.update_scriptdb`
  #
  # ### OS Detection:
  #
  # * `-O` - `nmap.os_fingerprint`
  # * `--osscan_limit` - `nmap.limit_os_scan`
  # * `--osscan_guess` - `nmap.max_os_scan`
  #
  # ### Timing and Performance:
  #
  # * `--min-hostgroup` - `nmap.min_host_group`
  # * `--max-hostgroup` - `nmap.max_host_group`
  # * `--min-parallelism` - `nmap.min_parallelism`
  # * `--max-parallelism` - `nmap.max_parallelism`
  # * `--min-rtt-timeout` - `nmap.min_rtt_timeout`
  # * `--max-rtt-timeout` - `nmap.max_rtt_timeout`
  # * `--max-retries` - `nmap.max_retries`
  # * `--host-timeout` - `nmap.host_timeout`
  # * `--scan-delay` - `nmap.scan_delay`
  # * `--max-scan-delay` - `nmap.max_scan_delay`
  # * `--min-rate` - `nmap.min_rate`
  # * `--max-rate` - `nmap.max_rate`
  #
  # ### Firewall/IDS Evasion and Spoofing:
  #
  # * `-f` - `nmap.packet_fragments`
  # * `--mtu` - `nmap.mtu`
  # * `-D` - `nmap.decoys`
  # * `-S` - `nmap.spoof`
  # * `-e` - `nmap.interface`
  # * `-g` - `nmap.source_port`
  # * `--data-length` - `nmap.data_length`
  # * `--ip-options` - `nmap.ip_options`
  # * `--ttl` - `nmap.ttl`
  # * `--spoof-mac` - `nmap.spoof_mac`
  # * `--badsum` - `nmap.bad_checksum`
  #
  # ### Output:
  #
  # * `-oN` - `nmap.save`
  # * `-oX` - `nmap.xml`
  # * `-oS` - `nmap.skiddie`
  # * `-oG` - `nmap.grepable`
  # * `-v` - `nmap.verbose`
  # * `--open` - `nmap.show_open_ports`
  # * `--packet-trace` - `nmap.show_packets`
  # * `--iflist` - `nmap.show_interfaces`
  # * `--log-errors` - `nmap.show_log_errors`
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
  # * `--send-eth` - `nmap.raw_ethernet`
  # * `--send-ip` - `nmap.raw_ip`
  # * `--privledged` - `nmap.privledged`
  # * `--unprivledged` - `nmap.unprivledged`
  # * `-V` - `nmap.version`
  # * `-h` - `nmap.help`
  #
  # * `target specification` - `nmap.targets`
  #
  # @see http://nmap.org/book/man.html
  #
  class Task < RProgram::Task

    # TARGET SPECIFICATIONS:
    short_option :flag => '-iL', :name => :target_file
    short_option :flag => '-iR', :name => :random_targets
    long_option :flag => '--exclude', :name => :exclude, :separator => ','
    long_option :flag => '--excludefile', :name => :exclude_file

    # HOST DISCOVERY:
    short_option :flag => '-sL', :name => :list
    short_option :flag => '-sP', :name => :ping
    short_option :flag => '-PN', :name => :skip_discovery
    short_option :flag => '-PS', :name => :syn_discovery
    short_option :flag => '-PA', :name => :ack_discovery
    short_option :flag => '-PU', :name => :udp_discovery
    short_option :flag => '-PE', :name => :icmp_echo_discovery
    short_option :flag => '-PP', :name => :icmp_timestamp_discovery
    short_option :flag => '-PM', :name => :icmp_netmask_discovery
    short_option :flag => '-PO', :name => :ip_ping
    short_option :flag => '-n', :name => :disable_dns
    short_option :flag => '-R', :name => :enable_dns
    long_option :flag => '--dns-servers', :separator => ','
    long_option :flag => '--system-dns'

    # SCAN TECHNIQUES:
    short_option :flag => '-sS', :name => :syn_scan
    short_option :flag => '-sT', :name => :connect_scan
    short_option :flag => '-sA', :name => :ack_scan
    short_option :flag => '-sW', :name => :window_scan
    short_option :flag => '-sM', :name => :maimon_scan
    short_option :flag => '-sU', :name => :udp_scan
    short_option :flag => '-sN', :name => :null_scan
    short_option :flag => '-sF', :name => :fin_scan
    short_option :flag => '-sX', :name => :xmas_scan
    long_option :flag => '--scanflags', :name => :tcp_scan_flags
    short_option :flag => '-sI', :name => :idle_scan
    short_option :flag => '-s0', :name => :ip_scan
    short_option :flag => '-b', :name => :ftp_bounce_scan
    long_option :flag => '--traceroute', :name => :traceroute
    long_option :flag => '--reason', :name => :show_reason

    # PORT SPECIFICATION AND SCAN ORDER:
    short_option :flag => '-p', :name => :ports do |opt,value|
      unless value.empty?
        [opt.flag, value.map { |port|
          case port
          when Range
            "#{port.first}-#{port.last}"
          else
            port.to_s
          end
        }.join(',')]
      else
        []
      end
    end

    short_option :flag => '-F', :name => :fast
    short_option :flag => '-r', :name => :consecutively
    long_option :flag => '--top-ports'
    long_option :flag => '--port-ratio'

    # SERVICE/VERSION DETECTION:
    short_option :flag => '-sV', :name => :service_scan
    long_option :flag => '--version-intensity'
    long_option :flag => '--version-light'
    long_option :flag => '--version-all'
    long_option :flag => '--version-trace'

    # SCRIPT SCAN:
    short_option :flag => '-sC', :name => :default_script
    long_option :flag => '--script'
    long_option :flag => '--script-args',
                :name => :script_params,
                :separator => ','
    long_option :flag => '--script-trace'
    long_option :flag => '--script-updatedb', :name => :update_scriptdb

    # OS DETECTION:
    short_option :flag => '-O', :name => :os_fingerprint
    long_option :flag => '--osscan_limit', :name => :limit_os_scan
    long_option :flag => '--osscan_guess', :name => :max_os_scan

    # TIMING AND PERFORMANCE:
    long_option :flag => '--min-hostgroup', :name => :min_host_group
    long_option :flag => '--max-hostgroup', :name => :max_host_group
    long_option :flag => '--min-parallelism'
    long_option :flag => '--max-parallelism'
    long_option :flag => '--min-rtt-timeout'
    long_option :flag => '--max-rtt-timeout'
    long_option :flag => '--max-retries'
    long_option :flag => '--host-timeout'
    long_option :flag => '--scan-delay'
    long_option :flag => '--max-scan-delay'
    long_option :flag => '--min-rate'
    long_option :flag => '--max-rate'

    # FIREWALL/IDS EVASION AND SPOOFING:
    short_option :flag => '-f', :name => :packet_fragments
    long_option :flag => '--mtu'
    short_option :flag => '-D', :name => :decoys, :separator => ','
    short_option :flag => '-S', :name => :spoof
    short_option :flag => '-e', :name => :interface
    short_option :flag => '-g', :name => :source_port
    long_option :flag => '--data-length'
    long_option :flag => '--ip-options'
    long_option :flag => '--ttl'
    long_option :flag => '--spoof-mac'
    long_option :flag => '--badsum', :name => :bad_checksum

    # OUTPUT:
    short_option :flag => '-oN', :name => :save
    short_option :flag => '-oX', :name => :xml
    short_option :flag => '-oS', :name => :skiddie
    short_option :flag => '-oG', :name => :grepable
    short_option :flag => '-v', :name => :verbose
    long_option :flag => '--open', :name => :show_open_ports
    long_option :flag => '--packet-trace', :name => :show_packets
    long_option :flag => '--iflist', :name => :show_interfaces
    long_option :flag => '--log-errors', :name => :show_log_errors
    long_option :flag => '--append-output', :name => :append
    long_option :flag => '--resume'
    long_option :flag => '--stylesheet'
    long_option :flag => '--webxml', :name => :nmap_stylesheet
    long_option :flag => '--no-stylesheet', :name => :disable_stylesheet

    # MISC:
    short_option :flag => '-6', :name => :ipv6
    short_option :flag => '-A', :name => :all
    long_option :flag => '--datadir', :name => :nmap_datadir
    long_option :flag => '--send-eth', :name => :raw_ethernet
    long_option :flag => '--send-ip', :name => :raw_ip
    long_option :flag => '--privledged'
    long_option :flag => '--unprivleged'
    short_option :flag => '-V', :name => :version
    short_option :flag => '-h', :name => :help

    non_option :tailing => true, :name => :targets

  end
end
