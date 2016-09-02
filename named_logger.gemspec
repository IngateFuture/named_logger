Gem::Specification.new do |gem|
  gem.name = 'named_logger'
  gem.version = '0.0.1'
  gem.date = '2016-09-02'
  gem.summary = 'Named Logger'
  gem.description = 'A simple logger with varied log file name'
  gem.authors = ['https://github.com/morr']
  gem.email = 'takandar@gmail.com'
  gem.files = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  gem.require_paths = ['lib']
  gem.license = 'MIT'
  # gem.homepage    = 'http://rubygems.org/gems/named_logger'

  gem.required_ruby_version = '>= 1.9.3'

  gem.add_dependency 'activesupport', '>= 4.0.0'

  gem.add_development_dependency 'byebug'
  gem.add_development_dependency 'pry-byebug'
  gem.add_development_dependency 'pry-stack_explorer'

  gem.add_development_dependency 'rb-inotify'
  gem.add_development_dependency 'rb-fsevent'
  gem.add_development_dependency 'rb-fchange'
  gem.add_development_dependency 'guard'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'guard-bundler'
  gem.add_development_dependency 'guard-rubocop'
end
