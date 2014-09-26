$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "redis_session_store/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "redis_session_store"
  s.version     = RedisSessionStore::VERSION
  s.authors     = ["Chris Weston"]
  s.email       = ["notsew66@yahoo.com"]
  s.homepage    = "https://github.com/Notsew/"
  s.summary     = "Redis session storage for Rails"
  s.description = "Redis session storage for Rails"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  #s.add_runtime_dependency 'actionpack', '>= 3', '< 5'
  s.add_runtime_dependency "redis", "~> 3.1"

  s.add_development_dependency "rails"
  s.add_development_dependency "sqlite3"
end
