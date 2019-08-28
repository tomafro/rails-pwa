$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "rails/pwa/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "rails-pwa"
  spec.version     = Rails::PWA::VERSION
  spec.authors     = ["Tom Ward"]
  spec.email       = ["tom@popdog.net"]
  spec.homepage    = "https://github.com/tomafro/rails-pwa"
  spec.summary     = "Serve service worker scripts from /worker.js"
  spec.description = "Serves service worker scripts"
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.0"
end
