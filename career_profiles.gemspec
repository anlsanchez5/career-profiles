
require_relative './lib/career_profiles/version'

Gem::Specification.new do |spec|
  spec.name          = "career_profiles"
  spec.version       = CareerProfiles::VERSION
  spec.date          = '2019-01-29'
  spec.authors       = ["'Angelica Sanchez'"]
  spec.email         = ["'anlsanchez@ucdavis.edu'"]
  spec.files         = ["lib/career_profiles.rb", "lib/career_profiles/cli.rb", "lib/career_profiles/career.rb", "lib/career_profiles/occupation.rb", "lib/career_profiles/scraper.rb"]
  spec.summary       = "Career Intrests and their Occupations"
  spec.description   = "Provides details on occupations by career interests."
  spec.homepage      = 'http://rubygems.org/gems/career-profiles'
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  #if spec.respond_to?(:metadata)
  #  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  #  spec.metadata["homepage_uri"] = spec.homepage
  #  spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  #  spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."
  #else
  #  raise "RubyGems 2.0 or newer is required to protect against " \
  #    "public gem pushes."
  #end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  #spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
  #  `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  #end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", ">= 0"
  spec.add_development_dependency "nokogiri", ">= 0"
  spec.add_development_dependency "pry", ">= 0"
end
