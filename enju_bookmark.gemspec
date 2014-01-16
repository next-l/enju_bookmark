$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "enju_bookmark/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "enju_bookmark"
  s.version     = EnjuBookmark::VERSION
  s.authors     = ["Kosuke Tanabe"]
  s.email       = ["kosuke@e23.jp"]
  s.homepage    = "https://github.com/next-l/enju_bookmark"
  s.summary     = "enju_bookmark plugin"
  s.description = "Purchase request management for Next-L Enju"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"] - Dir["spec/dummy/log/*"] - Dir["spec/dummy/solr/{data,pids}/*"]

  s.add_dependency "rails", "~> 4.0"
  s.add_dependency "acts-as-taggable-on", "~> 3.0"
  s.add_dependency "state_machine"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  #s.add_development_dependency "enju_leaf", "~> 1.1.0.rc5"
  s.add_development_dependency "sunspot_solr", "~> 2.1"
  s.add_development_dependency "mobylette"
  s.add_development_dependency "sunspot-rails-tester"
end
