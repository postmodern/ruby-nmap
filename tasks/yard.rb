lib_dir = File.expand_path(File.join(File.dirname(__FILE__),'..','lib'))
unless $LOAD_PATH.include?(lib_dir)
  $LOAD_PATH.unshift(lib_dir)
end

require 'yard'

YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb']
  t.options = [
    '--protected',
    '--files', 'History.txt',
    '--title', 'ruby-nmap',
    '--quiet'
  ]
end

task :docs => :yardoc
