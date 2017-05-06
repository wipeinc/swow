# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'swow/version'

Gem::Specification.new do |spec|
  spec.name          = "swow"
  spec.version       = Swow::VERSION
  spec.authors       = ["Sweetlie"]
  spec.email         = ["libellule.se@gmail.com"]

  spec.summary       = "Sweet battle.net wrapper for WoW armory"
  spec.homepage      = "https://github.com/wow-sweetlie/swow"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'faraday', '~> 0.11.0'
  spec.add_runtime_dependency 'addressable', '~> 2.5'
  spec.add_runtime_dependency 'oj', '~> 2.18'
  spec.add_runtime_dependency 'faraday_middleware', '~> 0.11.0.1'
  spec.add_runtime_dependency 'faraday_middleware-parse_oj', '~> 0.3.0'
  spec.add_runtime_dependency 'faraday-detailed_logger', '~> 2.1'
  spec.add_runtime_dependency 'thor', '~> 0.19.4'

  spec.add_development_dependency "bundler", "~> 1.13"
end
