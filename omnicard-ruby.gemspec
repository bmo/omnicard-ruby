# -*- encoding: utf-8 -*-

$:.push File.expand_path("../lib", __FILE__)

require "omnicard/version"

Gem::Specification.new do |s|
  s.name = %q{omnicard}
  s.version = Omnicard::VERSION
  s.date = %q{2018-10-22}
  s.summary = %q{omnicard works against the OmniCard API 2.x specification February 7, 2018}
  s.files = [
    "lib/omnicard_ruby.rb"
  ]

  s.authors     = ["Brian Moran"]
  s.email       = ["brian@trucentive.com"]
  s.require_paths = ["lib"]


  s.add_dependency 'hashie'
  s.add_dependency 'webmock'
  s.add_dependency 'faraday'
  s.add_dependency 'faraday_middleware'
  #s.add_dependency 'multi_json', '~> 1.8'
  #s.add_dependency 'multi_xml', '~> 0.5.0'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'webmock' 
  s.add_development_dependency 'rake'
  s.add_development_dependency 'redis'
end