$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "sortable_tree_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sortable_tree_rails"
  s.version     = SortableTreeRails::VERSION
  s.authors     = ["Max Ivak"]
  s.email       = ["maxivak@gmail.com"]
  s.homepage    = "https://github.com/maxivak/sortable_tree_rails"
  s.summary     = "GUI for sortable tree with ancestry gem"
  s.description = "GUI for sortable tree to manage data organized in tree with ancestry gem."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "readme.md"]

  s.add_dependency "rails", ">= 4.2.7"

  s.add_development_dependency "sqlite3"
end
