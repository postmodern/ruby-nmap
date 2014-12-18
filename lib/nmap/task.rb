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
  # * `-sn` - `nmap.ping`
  # * `-PN` - `nmap.skip_discovery`
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
  # * `--script-args` - `nmap.script_params`
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
  # * `--max-retries` - `nmap.max_retries`
  # * `--host-timeout` - `nmap.host_timeout`
  # * `--scan-delay` - `nmap.scan_delay`
  # * `--max-scan-delay` - `nmap.max_scan_delay`
  # * `--min-rate` - `nmap.min_rate`
  # * `--max-rate` - `nmap.max_rate`
  # * `--default-rst-ratelimit` - `nmap.default_rst_ratelimit`
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
  # * `--interactive` - `nmap.interactive`
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
    short_option :flag => '-sn', :name => :ping
    short_option :flag => '-PN', :name => :skip_discovery
    short_option :flag => '-PS', :name => :syn_discovery
    short_option :flag => '-PA', :name => :ack_discovery
    short_option :flag => '-PU', :name => :udp_discovery
    short_option :flag => '-PY', :name => :sctp_init_ping
    short_option :flag => '-PE', :name => :icmp_echo_discovery
    short_option :flag => '-PP', :name => :icmp_timestamp_discovery
    short_option :flag => '-PM', :name => :icmp_netmask_discovery
    short_option :flag => '-PO', :name => :ip_ping
    short_option :flag => '-PR', :name => :arp_ping
    long_option :flag => '--traceroute', :name => :traceroute
    short_option :flag => '-n', :name => :disable_dns
    short_option :flag => '-R', :name => :enable_dns
    long_option :flag => '--dns-servers', :separator => ','
    long_option :flag => '--system-dns'

    # PORT SCANNING TECHNIQUES:
    short_option :flag => '-sS', :name => :syn_scan
    short_option :flag => '-sT', :name => :connect_scan
    short_option :flag => '-sU', :name => :udp_scan
    short_option :flag => '-sY', :name => :sctp_init_scan
    short_option :flag => '-sN', :name => :null_scan
    short_option :flag => '-sF', :name => :fin_scan
    short_option :flag => '-sX', :name => :xmas_scan
    short_option :flag => '-sA', :name => :ack_scan
    short_option :flag => '-sW', :name => :window_scan
    short_option :flag => '-sM', :name => :maimon_scan
    long_option :flag => '--scanflags', :name => :tcp_scan_flags
    short_option :flag => '-sZ', :name => :sctp_cookie_echo_scan
    short_option :flag => '-sI', :name => :idle_scan
    short_option :flag => '-sO', :name => :ip_scan
    short_option :flag => '-b', :name => :ftp_bounce_scan

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
      end
    end

    short_option :flag => '-F', :name => :fast
    short_option :flag => '-r', :name => :consecutively
    long_option :flag => '--top-ports'
    long_option :flag => '--port-ratio'

    # SERVICE/VERSION DETECTION:
    short_option :flag => '-sV', :name => :service_scan
    long_option :flag => '--allports', :name => :all_ports
    long_option :flag => '--version-intensity'
    long_option :flag => '--version-light'
    long_option :flag => '--version-all'
    long_option :flag => '--version-trace'
    short_option :flag => '-sR', :name => :rpc_scan

    # SCRIPT SCAN:
    short_option :flag => '-sC', :name => :default_script
    long_option :flag => '--script', :separator => ','
    long_option :flag => '--script-args', :separator => ','
    alias script_params script_args
    alias script_params= script_args=
    long_option :flag => '--script-trace'
    long_option :flag => '--script-updatedb', :name => :update_scriptdb

    # OS DETECTION:
    short_option :flag => '-O', :name => :os_fingerprint
    long_option :flag => '--osscan-limit', :name => :limit_os_scan
    long_option :flag => '--osscan-guess', :name => :max_os_scan
    long_option :flag => '--max-os-tries', :name => :max_os_tries

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
    long_option :flag => '--default-rst-ratelimit'
    short_option :flag => '-T', :name => :timing_template
    short_option :flag => '-T0', :name => :paranoid_timing
    short_option :flag => '-T1', :name => :sneaky_timing
    short_option :flag => '-T2', :name => :polite_timing
    short_option :flag => '-T3', :name => :normal_timing
    short_option :flag => '-T4', :name => :aggressive_timing
    short_option :flag => '-T5', :name => :insane_timing

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
    long_option :flag => '--randomize-hosts'
    long_option :flag => '--spoof-mac'
    long_option :flag => '--badsum', :name => :bad_checksum
    long_option :flag => '--adler32', :name => :sctp_adler32

    # OUTPUT:
    short_option :flag => '-oN', :name => :save
    short_option :flag => '-oX', :name => :xml
    short_option :flag => '-oS', :name => :skiddie
    short_option :flag => '-oG', :name => :grepable
    short_option :flag => '-oA', :name => :output_all

    # Verbosity and Debugging:
    short_option :flag => '-v', :name => :verbose
    short_option :flag => '-d', :name => :debug
    long_option :flag => '--reason', :name => :show_reason
    long_option :flag => '--stats-every'
    long_option :flag => '--packet-trace', :name => :show_packets
    long_option :flag => '--open', :name => :show_open_ports
    long_option :flag => '--iflist', :name => :show_interfaces
    long_option :flag => '--log-errors', :name => :show_log_errors

    # Miscellaneous output:
    long_option :flag => '--append-output', :name => :append
    long_option :flag => '--resume'
    long_option :flag => '--stylesheet'
    long_option :flag => '--webxml', :name => :nmap_stylesheet
    long_option :flag => '--no-stylesheet', :name => :disable_stylesheet

    # MISC:
    short_option :flag => '-6', :name => :ipv6
    short_option :flag => '-A', :name => :all
    long_option :flag => '--datadir', :name => :nmap_datadir
    long_option :flag => '--servicedb'
    long_option :flag => '--versiondb'
    long_option :flag => '--send-eth', :name => :raw_ethernet
    long_option :flag => '--send-ip', :name => :raw_ip
    long_option :flag => '--privileged'
    long_option :flag => '--unprivleged'
    long_option :flag => '--release-memory'
    long_option :flag => '--interactive'
    short_option :flag => '-V', :name => :version
    short_option :flag => '-h', :name => :help

    non_option :tailing => true, :name => :targets

  end
end
