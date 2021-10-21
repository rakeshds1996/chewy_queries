require_relative 'lib/chewy_queries/version'

Gem::Specification.new do |spec|
  spec.name = 'chewy_queries'
  spec.version = ChewyQueries::VERSION
  spec.authors = ['Rakesh']
  spec.email = ['rakesh@example.com']
  spec.summary = 'chewy_queries!'
  spec.description = 'This gem help you to find the query for chewy gem'
  spec.homepage = 'https://github.com/gems/chewy_queries'
  spec.license = 'MIT'
  spec.platform = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.4.0'
  spec.files = Dir['README.md', 'LICENSE',
                   'CHANGELOG.md', 'lib/**/*.rb', 'lib/chewy_queries.rb',
                   'lib/**/*.rake',
                   'chewy_queries.gemspec', '.github/*.md',
                   'Gemfile', 'Rakefile']
  spec.extra_rdoc_files = ['README.md']
end
