# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "attribute_delegator/version"

Gem::Specification.new do |s|
  s.name        = "attribute_delegator"
  s.version     = AttributeDelegator::VERSION
  s.authors     = ["Clif Reeder"]
  s.email       = ["clif@voxmedia.com"]
  s.homepage    = ""
  s.summary     = %q{ActiveRecord extension that allows you to treat fields from another model/table as local attributes.}
  s.description = %q{AttributeDelegator provides a class method to ActiveRecord models that dynamically generates getter/setter to treat the attributes of a has_one model like native attributes. This is particularly useful because it allows the delegated attributes to be assigned via model.attributes= {}, such as by a form submission.}

  s.rubyforge_project = "attribute_delegator"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "activerecord", ">= 2.3.8"
  s.add_dependency "activesupport", ">= 2.3.8"
  s.add_development_dependency "sqlite3"
end
