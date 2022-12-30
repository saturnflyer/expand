lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "expand/version"

Gem::Specification.new do |spec|
  spec.name = "expand"
  spec.version = Expand::VERSION
  spec.authors = ["'Jim Gay'"]
  spec.email = ["jim@saturnflyer.com"]

  spec.summary = "Create classes and modules under an existing namespace"
  spec.description = "Create classes and modules under an existing namespace"
  spec.homepage = "https://github.com/saturnflyer/expand"
  spec.license = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
