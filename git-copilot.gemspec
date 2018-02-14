# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "git/copilot/version"

Gem::Specification.new do |spec|
  spec.name          = "git-copilot"
  spec.version       = Git::Copilot::VERSION
  spec.authors       = ["Matthew Patterson"]
  spec.email         = ["matthew.s.patterson@gmail.com"]

  spec.summary       = "Easily populate Git commit messages when pairing"
  spec.homepage      = "https://github/atmattpatt/git-copilot"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = %w[git-copilot]
  spec.require_paths = %w[lib]

  spec.add_dependency "thor", "~> 0.20"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "cucumber", "~> 3.1"
  spec.add_development_dependency "pry-byebug", "~> 3.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 0.52"
  spec.add_development_dependency "rubocop-rspec", "~> 1.22"
  spec.add_development_dependency "simplecov", "~> 0.15"
end
