### 0.3.0 / 2010-11-08

* Added {Nmap::Host#scripts}.
* Added {Nmap::Port#scripts}.

### 0.2.0 / 2010-10-29

* Require nokogiri >= 1.3.0.
* Require rprogram ~> 0.2.0.
* Added {Nmap::XML#tasks}.
* Added {Nmap::Scanner#start_time}.
* Added {Nmap::ScanTask#duration}.
* Added {Nmap::Host#start_time}.
* Added {Nmap::Host#end_time}.
* Allow `Nmap::Tasks#ports=` to accept port ranges.
* Omit the `-p` option if no ports are given to {Nmap::Task}.
* Have the `Nmap::Host#each_*` methods return an `Enumerator` object if no
  block is given.

### 0.1.1 / 2010-01-02

* Require RProgram >= 0.1.8.
  * Adds `sudo` and `sudo=` instance methods to {Nmap::Task}.

### 0.1.0 / 2009-11-13

* Initial release.
  * Provides a Ruby interface for running Nmap.
  * Provides a Parser for enumerating Nmap XML scan files.

