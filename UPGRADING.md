# Migration Guide

## 0.10.0 -> 1.0.0

### `Nmap::Program`/`Namp::Task` -> `Nmap::Command`

* Replace all method calls to `Nmap::Program.scan` with `Nmap::Command.run`.
* Replace all method calls to `Nmap::Program.sudo_scan` with `Nmap::Command.sudo`.
* Rename all instances of `raw_ip` with `send_ip`.
* Rename all instances of `raw_ethernet` to `send_eth`.
* Rename all instances of `disable_stylesheet` to `no_stylesheet`.
* Rename all instances of `nmap_stylesheet` to `webxml`.
* Rename all instances of `append` to `append_output`.
* Rename all instances of `save` to `output_normal`.
* Rename all instances of `grepable` to `output_grepable`.
* Rename all instances of `skiddie` to `output_skiddie`.
* Rename all instances of `xml` to `output_xml`.
* Rename all instances of `script_params` to `script_args`.
* Remove any instances of the `:interactive` option or `nmap.interactive`, as
  the `--interactive` option is no longer supported by nmap.

### `Nmap::XML`

* `Nmap::XML.new` now only accepts a parsed `Nokogiri::XML::Document` object.
  Use `Nmap::XML.open` or `Nmap::XML.parse` if you wish to parse XML files or
  strings.
* Replace any method calls to `Nmap::XML.load` with {Nmap::XML.parse}.
* Rename any method calls to `` to `tcp_sequence`.
* Rename any method calls to `tcpsequence` to `tcp_sequence`.
* Rename any method calls to `ipidsequence` to `ip_id_sequence`.
* Rename any method calls to `tcptssequence` to `tcp_ts_sequence`.
* Rename any method calls to `prescripts` to `prescript`.
* Rename any method calls to `postscripts` to `postscript`.
* The [scripts][Nmap::XML::Scripts#scripts] method now returns an Array of
  [Nmap::XML::Script] objects, instead of raw script output Strings.
  In order to access the raw script output Strings, call the
  [output][Nmap::XML::Script#output] method on each returned [Nmap::XML::Script]
  objects instead.
* The `script_data` method has been removed.
  In order to get the script's structured data, call
  the [data][Nmap::XML::Script#data] method on each returned [Nmap::XML::Script]
  objects instead.
* Rename any method calls to `extrainfo` to `extra_info`.

[Nmap::XML::Scripts#scripts]: https://rubydoc.info/gems/ruby-nmap/Nmap/XML/Scripts.html#scripts-instance_method
[Nmap::XML::Script]: https://rubydoc.info/gems/ruby-nmap/Nmap/XML/Script.html
[Nmap::XML::Script#output]: https://rubydoc.info/gems/ruby-nmap/Nmap/XML/Script.html#output-instance_method
