# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

if RUBY_VERSION < '2.0.0'
  require 'sensu-plugins-nexmos'
else
  require_relative 'lib/sensu-plugins-nexmos'
end

Gem::Specification.new do |spec|
  spec.name                   = 'sensu-plugins-nexmos'
  spec.version                = SensuPluginsNexmos::Version::VER_STRING
  spec.authors                = ['wakwanza']
  spec.email                  = ['wakwanza@@users.noreply.github.com']
  spec.cert_chain             = ['certs/sensu-plugins.pem']

  spec.summary                = 'Sensu plugins handler for notification with nexmo sms and voice'
  spec.description            = 'Sensu plugins handler for notification with nexmo sms and voice'
  spec.homepage               = ''
  spec.license                = 'MIT'
  spec.metadata               = { 'maintainer'         => 'wakwanza',
                                  'development_status' => 'active',
                                  'production_status'  => 'unstable - testing recommended',
                                  'release_draft'      => 'false',
                                  'release_prerelease' => 'false'
                                }

  spec.files                  = Dir.glob('{bin,lib}/**/*') + %w(LICENSE README.md)
  spec.platform               = Gem::Platform::RUBY
  spec.executables            = Dir.glob('bin/**/*.rb').map { |file| File.basename(file) }
  spec.require_paths          = ['lib']
  spec.test_files             = spec.files.grep(%r{^(test|spec|features)/})
  spec.required_ruby_version  = '>= 1.9.3'

  spec.add_runtime_dependency 'nexmo'
  spec.add_runtime_dependency 'sensu-plugin'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rspec'
end
