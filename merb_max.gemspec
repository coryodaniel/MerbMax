@spec = Gem::Specification.new do |s|
  s.name = %q{merb_max}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Cory ODaniel"]
  s.date = %q{2008-09-24}
  s.description = %q{A serious of random useful merb things.}
  s.email = %q{merb_max@coryodaniel.com}
  
  s.extra_rdoc_files = ["README", "LICENSE", "TODO"]
  s.files = ["LICENSE", "README", "Rakefile", "TODO", 
    "lib/merb_max", 
    "lib/merb_max/all.rb",
    "lib/merb_max.rb", 
    "lib/merb_max/coerce.rb",
    "lib/merb_max/meta.rb",
    "lib/merb_max/roles.rb",
    "lib/merb_max/roles/helpers.rb",
    "lib/merb_max/coerce/helpers.rb",
    "lib/merb_max/core_ext/hash_coercion.rb",
    "spec/merb_meta_spec.rb", 
    "spec/spec_helper.rb"]
  s.has_rdoc = true
  s.homepage = "http://github.com/coryodaniel/merb_max"
  s.require_paths = ["lib"]
  #s.rubyforge_project = %q{merb}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{A serious of random useful merb things include Controller controlled meta tags, thresholding, coercion, etc.}
end
