lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cron_parser/version'

Gem::Specification.new do |spec|
  spec.name = 'cron_parser'
  spec.version = CronParser::VERSION
  spec.authors = ['Filipe Barros']
  spec.email = ['afbarros@me.com']

  spec.summary = 'Deliveroo Tech Task'
  spec.description = 'Deliveroo Tech Task'
  spec.homepage = 'https://bitbucket.org/fbarros/cron_parser'
  spec.license = 'MIT'

  spec.files =
    Dir.glob('{bin,lib}/**/*') +
    %w[LICENSE README.md] +
    %w[cron_parser.gemspec Gemfile Gemfile.lock Rakefile]
  spec.bindir = 'bin'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'thor'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rspec'
end
