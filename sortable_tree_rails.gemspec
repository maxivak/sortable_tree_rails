$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "sortable_tree_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sortable_tree_rails"
  s.version     = SortableTreeRails::VERSION
  s.authors     = ["Max Ivak"]
  s.email       = ["maxivak@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of SortableTreeRails."
  s.description = "TODO: Description of SortableTreeRails."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "readme.md"]

  s.add_dependency "rails", "~> 4.2.5.2"

  s.add_development_dependency "sqlite3"
end
