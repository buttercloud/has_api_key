$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "has_api_key/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "has_api_key"
  s.version     = HasApiKey::VERSION
  s.authors     = ["Feras Hirzalla"]
  s.email       = ["hirzalla@gmail.com"]
  s.homepage    = "http://www.buttercloud.com"
  s.summary     = "Easily add resoure-based API authentication to your rails application"
  s.description = "Add API key support to your application."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"

  s.add_development_dependency "sqlite3"
end
