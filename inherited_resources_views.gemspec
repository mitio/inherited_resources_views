
Gem::Specification.new do |s|
  s.name = "inherited_resources_views"
  s.version = `git tag | tail -1`.strip.gsub(/^v/,'')
  s.platform = Gem::Platform::RUBY
  s.authors = ["Fred Wu", "Jonhnny Weslley"]
  s.email = "jw@jonhnnyweslley.net"
  s.homepage = "http://github.com/jweslley/inherited_resources_views"

  s.summary = "A lot of times resources share the same views, so why not DRY 'em up using Inherited Resources Views!"
  s.description = "Using Inherited Resources is an excellent way to reduce the amount of repetition in your controllers. But what about views? A lot of times resources share the same views, so why not DRY 'em up using Inherited Resources Views!"

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- test/*`.split("\n")
  s.extra_rdoc_files = ["README.md"]
  s.require_paths = ["lib"]

  s.add_dependency("inherited_resources", "~> 1.0")
  s.add_dependency("hpricot", "~> 0")
  s.add_dependency("ruby_parser", "~> 0")
end
