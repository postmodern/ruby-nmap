### 1.0.0 / 2022-11-11

* Switched from [rprogram] to [command_mapper].
* Replaced `Nmap::Program` and `Nmap::Task` with {Nmap::Command}.
* Moved all XML classes under {Nmap::XML}.
* See [UPGRADING] for more details on how to upgrade from 0.10.0 to 1.0.0.

#### Nmap::Command

* Added support for the `--unique` option as `nmap.unique`.
* Added support for the `--resolve-all` option as `nmap.resolve_all`.
* Added support for the `--noninteractive` option as `nmap.non_interactive`.
* Added support for the `--proxies` option as `nmap.proxies`.
* Added support for the `--data` option as `nmap.data`.
* Added support for the `--data-string` option as `nmap.data_string`.
* Added support for the `--script-help` option as `nmap.script_help`.
* Added support for the `--script-args-file` option as `nmap.script_args_file`.
* Added support for the `--script-timeout` option as `nmap.script_timeout`.
* Added support for the `--initial-rtt-timeout` option as
  `nmap.initial_rtt_timeout`.
* Added support for the `-vv` option as `nmap.extra_verbose`.
* Allow passing Integer values to `verbose:` or `nmap.verbose=` for
  `-v`**level**.
* Greatly improved the validation of input values.
* Removed `#script_params` and `#script_params=` aliases for `#script_args` and
  `#script_args=`.

#### Nmap::XML

* Removed the deprecated `Nmap::XML.load` method in favor of {Nmap::XML.parse}.
* Removed the `Nmap::XML#prescripts` alias to `Nmap::XML#prescript`.
* Removed the `Nmap::XML#postscripts` alias to `Nmap::XML#postscript`.
* Removed `Nmap::XML::Host#tcpsequence` in favor of
  {Nmap::XML::Host#tcp_sequence}.
* Removed `Nmap::XML::Host#ipidsequence` in favor of
  {Nmap::XML::Host#ip_id_sequence}.
* Removed `Nmap::XML::Host#tcptssequence` in favor of
  {Nmap::XML::Host#tcp_ts_sequence}.
* Removed `Nmap::XML#inspect` method.
* Added {Nmap::XML::Script}.
* Removed `Nmap::XML::Scripts#script_data`.
* Changed {Nmap::XML::Scripts#scripts} to return {Nmap::XML::Script} objects.

### 0.10.0 / 2020-03-17

* Added `Nmap::Task#exclude_ports` for the `--exclude-ports` option.
* Added `Nmap::Status#reason_ttl`.
* Added `Nmap::Port#reason_ttl`.
* Added `Nmap::XML#task`.
* Alias `Nmap::ScanTask#extra_info` to `Nmap::ScanTask#extrainfo`.

### 0.9.3 / 2018-05-01

* Added missing `Nmap::Task#defeat_icmp_ratelimit` for the
  `--defeat-icmp-ratelimit` option.
* Added missing `Nmap::Task#nsock_engine` for the `--nsock-engine` option.
* Added the `Nmap::XML#prescripts` alias.
* Added the `Nmap::XML#postscripts` alias.
* Allow `Task#sctp_init_ping` to accept a port Range object.
* Fixed a typo in the `Task#defeat_rst_ratelimit` name.
* Fixed the option formatting of `Nmap::Task#syn_discovery`.
* Fixed the option formatting of `Nmap::Task#ack_discovery`.
* Fixed the option formatting of `Nmap::Task#udp_discovery`.
* Fixed the option formatting of `Nmap::Task#sctp_init_ping`.
* Fixed the option formatting of `Nmap::Task#ip_ping`.

### 0.9.2 / 2017-01-13

* Fix file descriptor leak in `Nmap::XML#initialize` by using
  `File.open(path) { |file| ... }` instead of `File.new(path)`, which keeps the
  file descriptor open until GC collects the `File` instance.

### 0.9.1 / 2016-07-18

* Fixed `Nmap::Host#ipv6` when there are no `ipv6` type addresses.
* Fixed `Nmap::OS#fingerprint` when there is no `osfingerprint` element.

### 0.9.0 / 2016-07-14

* Added `Nmap::Address#vendor`.
* Added `Nmap::Service#to_s`.
* Added `Nmap::HostScript`.
* Added `Nmap::Prescript`.
* Added `Nmap::Postscript`.
* Added `Nmap::XML#prescript`.
* Added `Nmap::XML#postscript`.
* Added `Nmap::Task#quiet` (aka `-v0`).
* `#script_data` methods can now parse arbitrarily nested Arrays/Hashes.
* Fixed `Nmap::CPE#each_cpe` to only match child `cpe` elements, not all
  `cpe` elements within the document.
* Changed `Nmap::Service#to_s` to output product/version only if both are
  present.
* Changed `Nmap::Task#skip_discovery` to use `-Pn` instead of `-PN`, which was
  deprecated in nmap >= 7.00.

### 0.8.0 / 2014-04-16

* Added `Nmap::XML#each_down_host`.
* Added `Nmap::XML#down_hosts`.
* Added `Nmap::XML#host`.
* Added `Nmap::XML#up_host`.
* Added `Nmap::XML#down_host`.
* Added `Nmap::Host#hostname`.
* Added `Nmap::Hostname#user?`.
* Added `Nmap::Hostname#ptr?`.
* Added `Nmap::Program.sudo_scan`.
* Added `Nmap::Program#sudo_scan`.
* Renamed `Nmap::XML.load` to `Nmap::XML.parse`.
* Fixed a typo in the `--privileged` flag (@BrentonEarl)
* Allow multiple values in the `--script` flag.
* Alias `Nmap::Task#script_params` to `script_args`.

### 0.7.0 / 2014-05-09

* Added `Nmap::CPE`.
* Added `Nmap::CPE::URL`.
* Added `Nmap::Hop`.
* Added `Nmap::Hostname`.
* Added `Nmap::Traceroute`.
* Added `Nmap::Host#traceroute`.
* Added `Nmap::Host#uptime`. (@roodee)
* Added `Nmap::Service#ssl?`.
* Added `Nmap::Service#protocol`.
* Added `Nmap::Service#extra_info`.
* Added `Nmap::Service#os_type`.
* Added `Nmap::Service#device_type`.
* Added `Nmap::Service#fingerprint`. (@roodee)
* Added `Nmap::Uptime`. (@roodee)
* Added `Nmap::RunStat`. (@roodee)
* Added `Nmap::XML.load`. (@vzctl)
* Added `Nmap::XML.open`.
* Added `Nmap::XML#each_run_stat`.
* Added `Nmap::XML#run_stats`.
* Added `Nmap::XML#each_task`.
* Fixed xpath bug in `Nmap::OS#each_class` (@roodee).

### 0.6.0 / 2012-11-07

* Added `Nmap::Service`.
* Renamed `Nmap::IpidSequence` to `Nmap::IpIdSequence`.
* Renamed `Nmap::Host#ipidsequence` to `Nmap::Host#ip_id_sequence`.
* Renamed `Nmap::Host#tcpsequence` to `Nmap::Host#tcp_sequence`.
* Renamed `Nmap::Host#tcptssequence` to `Nmap::Host#tcp_ts_sequence`.

### 0.5.1 / 2012-05-27

* Replaced ore-tasks with
  [rubygems-tasks](https://github.com/postmodern/rubygems-tasks#readme).

### 0.5.0 / 2011-04-11

* Require nokogiri ~> 1.3.
* Require rprogram ~> 0.3.
* `ip_scan` in `Nmap::Task` should map to `-sO` (thanks corvus).

### 0.4.1 / 2010-11-23

* Fixed a bug in `Nmap::XML#each` where it was calling `each_up_hosts`,
  and not `Nmap::XML#each_up_host`.
* `Nmap::OS#each_class`, `Nmap::OS#each_match`, `Nmap::XML#each_host` and
  `Nmap::XML#each_up_host` now return an Enumerator object if no block
  is given.
* Use `yield` instead of `block.call` for a slight performance improvement.

### 0.4.0 / 2010-11-17

* Added new options to `Nmap::Task` based on nmap 5.21:
  * `-PY` - `nmap.sctp_init_ping`
  * `-PR` - `nmap.arp_ping`
  * `-sY` - `nmap.sctp_init_scan`
  * `-sZ` - `nmap.sctp_cookie_echo_scan`
  * `--allports` - `nmap.all_ports`
  * `-sR` - `nmap.rpc_scan`
  * `-T` - `nmap.timing_template`
  * `-T0` - `nmap.paranoid_timing`
  * `-T1` - `nmap.sneaky_timing`
  * `-T2` - `nmap.polite_timing`
  * `-T3` - `nmap.normal_timing`
  * `-T4` - `nmap.aggressive_timing`
  * `-T5` - `nmap.insane_timing`
  * `--randomize-hosts` - `nmap.randomize_hosts`
  * `--adler32` - `nmap.sctp_adler32`
  * `-oA` - `nmap.output_all`
  * `-d` - `nmap.debug`
  * `--stats-every` - `nmap.stats_every`
  * `--release-memory` - `nmap.release_memory`
* Specify that ruby-nmap requires `nmap` >= 5.00.

### 0.3.0 / 2010-11-08

* Added `Nmap::Host#scripts`.
* Added `Nmap::Port#scripts`.

### 0.2.0 / 2010-10-29

* Require nokogiri >= 1.3.0.
* Require rprogram ~> 0.2.0.
* Added `Nmap::XML#tasks`.
* Added `Nmap::Scanner#start_time`.
* Added `Nmap::ScanTask#duration`.
* Added `Nmap::Host#start_time`.
* Added `Nmap::Host#end_time`.
* Allow `Nmap::Tasks#ports=` to accept port ranges.
* Omit the `-p` option if no ports are given to `Nmap::Task`.
* Have the `Nmap::Host#each_*` methods return an `Enumerator` object if no
  block is given.

### 0.1.1 / 2010-01-02

* Require RProgram >= 0.1.8.
  * Adds `sudo` and `sudo=` instance methods to `Nmap::Task`.

### 0.1.0 / 2009-11-13

* Initial release.
  * Provides a Ruby interface for running Nmap.
  * Provides a Parser for enumerating Nmap XML scan files.

[rprogram]: https://github.com/postmodern/rprogram#readme
[command_mapper]: https://github.com/postmodern/command_mapper.rb#readme

[UPGRADING]: https://github.com/postmodern/ruby-nmap/blob/main/UPGRADING.md
