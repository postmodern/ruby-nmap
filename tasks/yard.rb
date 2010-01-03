require 'yard'

YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb']
  t.options = [
    '--protected',
    '--files', 'History.rdoc',
    '--title', 'ruby-nmap',
    '--quiet'
  ]
end

task :docs => :yard
