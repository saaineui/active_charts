# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "active_charts/version"

Gem::Specification.new do |spec|
  spec.name          = "active_charts"
  spec.version       = ActiveCharts::VERSION
  spec.authors       = ["saaineui"]

  spec.summary       = %q{Beautiful, easy charts for ActiveRecord and Rails.}
  spec.description   = %q{Charting toolset that integrates into ActiveRecord and ActionView for fast, easy business intelligence and data visualization on any Rails app. Uses inline SVG wherever possible for best performance on the web. Javascript is used only when absolutely necessary.}
  spec.homepage      = "https://github.com/saaineui/active_charts"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org/"
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
  
  spec.required_ruby_version = '>= 2.2.2'
  
  spec.add_dependency "rails", ">= 5.0.1"
  spec.add_dependency 'sass-rails', '~> 5.0'
  spec.add_dependency "thor"
  
  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.5"
  spec.add_development_dependency "rspec", "~> 3.6"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "aruba"
  spec.add_development_dependency "jasmine"
  spec.add_development_dependency "simplecov"
end
