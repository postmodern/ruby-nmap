require 'rprogram/task'

module Nmap
  #
  # == Nmap options:
  #
  # === Target Specifications:
  #
  # <tt>-iL</tt>:: <tt>nmap.target_file</tt>
  # <tt>-iR</tt>:: <tt>nmap.random_targets</tt>
  # <tt>--exclude</tt>:: <tt>nmap.exclude</tt>
  # <tt>--excludefile</tt>:: <tt>nmap.exclude_file</tt>
  #
  # === Host Discovery:
  #
  # <tt>-sL</tt>:: <tt>nmap.list</tt>
  # <tt>-sP</tt>:: <tt>nmap.ping</tt>
  # <tt>-PN</tt>:: <tt>nmap.skip_discovery</tt>
  # <tt>-PS</tt>:: <tt>nmap.syn_discovery</tt>
  # <tt>-PA</tt>:: <tt>nmap.ack_discovery</tt>
  # <tt>-PU</tt>:: <tt>nmap.udp_discovery</tt>
  # <tt>-PE</tt>:: <tt>nmap.icmp_echo_discovery</tt>
  # <tt>-PP</tt>:: <tt>nmap.icmp_timestamp_discovery</tt>
  # <tt>-PM</tt>:: <tt>nmap.icmp_netmask_discovery</tt>
  # <tt>-PO</tt>:: <tt>nmap.ip_ping</tt>
  # <tt>-n</tt>:: <tt>nmap.disable_dns</tt>
  # <tt>-R</tt>:: <tt>nmap.enable_dns</tt>
  # <tt>--dns-servers</tt>:: <tt>nmap.dns_servers</tt>
  # <tt>--systems-dns</tt>:: <tt>nmap.systems_dns</tt>
  #
  # === Scan Techniques:
  #
  # <tt>-sS</tt>:: <tt>nmap.syn_scan</tt>
  # <tt>-sT</tt>:: <tt>nmap.connect_scan</tt>
  # <tt>-sA</tt>:: <tt>nmap.ack_scan</tt>
  # <tt>-sW</tt>:: <tt>nmap.window_scan</tt>
  # <tt>-sM</tt>:: <tt>nmap.maimon_scan</tt>
  # <tt>-sU</tt>:: <tt>nmap.udp_scan</tt>
  # <tt>-sN</tt>:: <tt>nmap.null_scan</tt>
  # <tt>-sF</tt>:: <tt>nmap.fin_scan</tt>
  # <tt>-sX</tt>:: <tt>nmap.xmas_scan</tt>
  # <tt>--scanflags</tt>:: <tt>nmap.tcp_scan_flags</tt>
  # <tt>-sI</tt>:: <tt>nmap.idle_scan</tt>
  # <tt>-s0</tt>:: <tt>nmap.ip_scan</tt>
  # <tt>-b</tt>:: <tt>nmap.ftp_bounce_scan</tt>
  # <tt>--traceroute</tt>:: <tt>nmap.traceroute</tt>
  # <tt>--reason</tt>:: <tt>nmap.show_reason</tt>
  #
  # === Port Specification and Scan Order:
  #
  # <tt>-p</tt>:: <tt>nmap.ports</tt>
  # <tt>-F</tt>:: <tt>nmap.fast</tt>
  # <tt>-r</tt>:: <tt>nmap.consecutively</tt>
  # <tt>--top-ports</tt>:: <tt>nmap.top_ports</tt>
  # <tt>--port-ratio</tt>:: <tt>nmap.port_ratio</tt>
  #
  # === Service/Version Detection:
  #
  # <tt>-sV</tt>:: <tt>nmap.service_scan</tt>
  # <tt>--version-intensity</tt>:: <tt>nmap.version_intensity</tt>
  # <tt>--version-light</tt>:: <tt>nmap.version_light</tt>
  # <tt>--version-all</tt>:: <tt>nmap.version_all</tt>
  # <tt>--version-trace</tt>:: <tt>nmap.version_trace</tt>
  #
  # === Script Scan:
  #
  # <tt>-sC</tt>:: <tt>nmap.default_script</tt>
  # <tt>--script</tt>:: <tt>nmap.script</tt>
  # <tt>--script-args</tt>:: <tt>nmap.script_params</tt>
  # <tt>--script-trace</tt>:: <tt>nmap.script_trace</tt>
  # <tt>--script-updatedb</tt>:: <tt>nmap.update_scriptdb</tt>
  #
  # === OS Detection:
  #
  # <tt>-O</tt>:: <tt>nmap.os_fingerprint</tt>
  # <tt>--osscan_limit</tt>:: <tt>nmap.limit_os_scan</tt>
  # <tt>--osscan_guess</tt>:: <tt>nmap.max_os_scan</tt>
  #
  # === Timing and Performance:
  #
  # <tt>--min-hostgroup</tt>:: <tt>nmap.min_host_group</tt>
  # <tt>--max-hostgroup</tt>:: <tt>nmap.max_host_group</tt>
  # <tt>--min-parallelism</tt>:: <tt>nmap.min_parallelism</tt>
  # <tt>--max-parallelism</tt>:: <tt>nmap.max_parallelism</tt>
  # <tt>--min-rtt-timeout</tt>:: <tt>nmap.min_rtt_timeout</tt>
  # <tt>--max-rtt-timeout</tt>:: <tt>nmap.max_rtt_timeout</tt>
  # <tt>--max-retries</tt>:: <tt>nmap.max_retries</tt>
  # <tt>--host-timeout</tt>:: <tt>nmap.host_timeout</tt>
  # <tt>--scan-delay</tt>:: <tt>nmap.scan_delay</tt>
  # <tt>--max-scan-delay</tt>:: <tt>nmap.max_scan_delay</tt>
  # <tt>--min-rate</tt>:: <tt>nmap.min_rate</tt>
  # <tt>--max-rate</tt>:: <tt>nmap.max_rate</tt>
  #
  # === Firewall/IDS Evasion and Spoofing:
  #
  # <tt>-f</tt>:: <tt>nmap.packet_fragments</tt>
  # <tt>--mtu</tt>:: <tt>nmap.mtu</tt>
  # <tt>-D</tt>:: <tt>nmap.decoys</tt>
  # <tt>-S</tt>:: <tt>nmap.spoof</tt>
  # <tt>-e</tt>:: <tt>nmap.interface</tt>
  # <tt>-g</tt>:: <tt>nmap.source_port</tt>
  # <tt>--data-length</tt>:: <tt>nmap.data_length</tt>
  # <tt>--ip-options</tt>:: <tt>nmap.ip_options</tt>
  # <tt>--ttl</tt>:: <tt>nmap.ttl</tt>
  # <tt>--spoof-mac</tt>:: <tt>nmap.spoof_mac</tt>
  # <tt>--badsum</tt>:: <tt>nmap.bad_checksum</tt>
  #
  # === Output:
  #
  # <tt>-oN</tt>:: <tt>nmap.save</tt>
  # <tt>-oX</tt>:: <tt>nmap.xml</tt>
  # <tt>-oS</tt>:: <tt>nmap.skiddie</tt>
  # <tt>-oG</tt>:: <tt>nmap.grepable</tt>
  # <tt>-v</tt>:: <tt>nmap.verbose</tt>
  # <tt>--open</tt>:: <tt>nmap.show_open_ports</tt>
  # <tt>--packet-trace</tt>:: <tt>nmap.show_packets</tt>
  # <tt>--iflist</tt>:: <tt>nmap.show_interfaces</tt>
  # <tt>--log-errors</tt>:: <tt>nmap.show_log_errors</tt>
  # <tt>--append-output</tt>:: <tt>nmap.append</tt>
  # <tt>--resume</tt>:: <tt>nmap.resume</tt>
  # <tt>--stylesheet</tt>:: <tt>nmap.stylesheet</tt>
  # <tt>--webxml</tt>:: <tt>nmap.nmap_stylesheet</tt>
  # <tt>--no-stylesheet</tt>:: <tt>nmap.disable_stylesheet</tt>
  #
  # === Misc:
  #
  # <tt>-6</tt>:: <tt>nmap.ipv6</tt>
  # <tt>-A</tt>:: <tt>nmap.all</tt>
  # <tt>--datadir</tt>:: <tt>nmap.nmap_datadir</tt>
  # <tt>--send-eth</tt>:: <tt>nmap.raw_ethernet</tt>
  # <tt>--send-ip</tt>:: <tt>nmap.raw_ip</tt>
  # <tt>--privledged</tt>:: <tt>nmap.privledged</tt>
  # <tt>--unprivledged</tt>:: <tt>nmap.unprivledged</tt>
  # <tt>-V</tt>:: <tt>nmap.version</tt>
  # <tt>-h</tt>:: <tt>nmap.help</tt>
  #
  # <tt>target specification</tt>:: <tt>nmap.targets</tt>
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
    short_option :flag => '-p', :name => :ports, :separator => ','
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
