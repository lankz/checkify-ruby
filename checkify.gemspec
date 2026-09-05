require_relative "lib/checkify/version"

Gem::Specification.new do |s|
  s.name        = "checkify"
  s.version     = Checkify::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ben Caldwell"]
  s.homepage    = "https://github.com/lankz/checkify-ruby"
  s.summary     = "Unofficial Ruby client for the Checkify API"
  s.description = "Australian and New Zealand address validation, business lookups, identity checks, and communication validation."
  s.license     = "MIT"
  s.required_ruby_version = ">= 3.3"
  s.metadata = {
    "source_code_uri" => s.homepage,
    "documentation_uri" => "#{s.homepage}#readme",
    "bug_tracker_uri" => "#{s.homepage}/issues",
    "changelog_uri" => "#{s.homepage}/blob/master/CHANGELOG.md"
  }

  s.add_runtime_dependency 'logger', '~> 1.6'
  s.add_runtime_dependency 'typhoeus', '~> 1.0', '>= 1.0.1'

  s.add_development_dependency 'rspec', '~> 3.6', '>= 3.6.0'

  s.files         = Dir["lib/**/*.rb", "docs/**/*.md"] + %w[README.md LICENSE CHANGELOG.md openapi.yaml]
  s.executables   = []
  s.require_paths = ["lib"]
end
