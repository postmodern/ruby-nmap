# -*- ruby -*-

require 'rubygems'
require 'hoe'

Hoe.plugin :yard

Hoe.spec 'ruby-nmap' do
  self.developer('Postmodern', 'postmodern.mod3@gmail.com')

  self.rspec_options += ['--colour', '--format', 'specdoc']

  self.yard_options += ['--protected']
  self.remote_yard_dir = '/'

  self.extra_deps = [
    ['nokogiri', '>=1.4.0'],
    ['rprogram', '>=0.1.8']
  ]

  self.extra_dev_deps = [
    ['rspec', '>=1.3.0'],
    ['yard', '>=0.2.3.5']
  ]
end

# vim: syntax=ruby
