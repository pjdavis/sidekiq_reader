# frozen_string_literal: true

require_relative 'lib/sidekiq_reader/version'

Gem::Specification.new do |spec|
  spec.name = 'sidekiq_reader'
  spec.version = SidekiqReader::VERSION
  spec.authors = ['PJ Davis']
  spec.email = ['pj.davis@gmail.com']

  spec.summary = 'Command line tool for reading Sidekiq stats'
  spec.description = <<~DESC
    Command line tool for reading Sidekiq stats. Scrapes information from the#{' '}
    Sidekiq web interface for times you don't have access to the underlying#{' '}
    Redis instance.
  DESC
  spec.homepage = 'https://github.com/pjdavis/sidekiq_reader'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.7.6'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.metadata['allowed_push_host'] = 'https://github.com'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  spec.add_runtime_dependency 'dotenv'
  spec.add_runtime_dependency 'httparty'
  spec.add_runtime_dependency 'nokogiri'
  spec.add_runtime_dependency 'thor'

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |file|
      (file == __FILE__) || file.match(%r{\A(?:(?:bin|spec)/|\.(?:git))})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |file| File.basename(file) }
  spec.require_paths = ['lib']
end
