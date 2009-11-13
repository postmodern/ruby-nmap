# -*- ruby -*-

require 'rubygems'
require 'hoe'
require './tasks/spec.rb'
require './tasks/yard.rb'

Hoe.spec 'ruby-nmap' do
  self.developer('Postmodern', 'postmodern.mod3@gmail.com')
  self.extra_deps = [
    ['nokogiri', '>=1.4.0'],
    ['rprogram', '>=0.1.7']
  ]

  self.extra_dev_deps = [
    ['rspec', '>=1.1.12'],
    ['yard', '>=0.2.3.5']
  ]

  self.spec_extras = {:has_rdoc => 'yard'}
end

# vim: syntax=ruby
