$:.push File.expand_path("../lib", __FILE__)
require "rackatweet/version"

Gem::Specification.new do |s|
  s.name        = "rackatweet"
  s.version     = GeoIPJson::VERSION
  s.authors     = ["Kevin Edwards"]
  s.email       = ["kev.j.edwards@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Get tweets JSON rack app}
  s.description = %q{Get tweets via JSON rack app}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "geoip"
end
