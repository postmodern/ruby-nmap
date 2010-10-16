source 'https://rubygems.org'

group(:runtime) do
  gem 'nokogiri',	'>= 1.3.0'
  gem 'rprogram',	'~> 0.2.0'
end

group(:development) do
  gem 'rake',			'~> 0.8.7'
  gem 'jeweler',		'~> 1.5.0.pre'
end

group(:doc) do
  case RUBY_PLATFORM
  when 'java'
    gem 'maruku',	'~> 0.6.0'
  else
    gem 'rdiscount',	'~> 1.6.3'
  end

  gem 'yard',		'~> 0.6.0'
end

gem 'rspec',	'~> 2.0.0', :group => [:development, :test]
