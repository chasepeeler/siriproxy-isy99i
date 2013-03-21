# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "siriproxy-isy99i"
  s.version     = "0.3.0" 
  s.authors     = ["hoopty3", "elvisimprsntr"]
  s.email       = [""]
  s.homepage    = "https://github.com/elvisimprsntr/siriproxy-isy99i"
  s.summary     = %q{Siri Proxy ISY-99i Plugin}
  s.description = %q{This is a plugin that lets users interact with their ISY-99i through Siri. }

  s.rubyforge_project = ""

  s.files         = `git ls-files 2> /dev/null`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/* 2> /dev/null`.split("\n")
  s.executables   = `git ls-files -- bin/* 2> /dev/null`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_runtime_dependency "httparty"
  s.add_runtime_dependency "simple_upnp"
  s.add_runtime_dependency "siriproxy", ">=0.5.2"



end
