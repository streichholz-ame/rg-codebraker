require_relative 'lib/codebraker/version'

Gem::Specification.new do |spec|
  spec.name          = 'codebraker'
  spec.version       = Codebraker::VERSION
  spec.authors       = ['Anastasiia Ovcharenko']
  spec.email         = ['ovcharenko.nastia@gmail.com']

  spec.summary       = 'Write a short summary, because RubyGems requires one.'
  spec.description   = 'Write a longer description or delete this line.'
  spec.homepage      = 'https://github.com/streichholz-ame/codebraker'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.0')

  spec.metadata['allowed_push_host'] = "Set to 'https://github.com/streichholz-ame/ruby-codebraker'"

  spec.metadata['https://github.com/streichholz-ame/codebraker'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/streichholz-ame'
  spec.metadata['changelog_uri'] = 'https://github.com/streichholz-ame'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'fasterer', '~> 0.9.0'
  spec.add_development_dependency 'i18n', '~> 1.8', '>= 1.8.8'
  spec.add_development_dependency 'pry', '~> 0.2'
  spec.add_development_dependency 'rspec', '~> 3.10'
  spec.add_development_dependency 'rubocop', '~> 1.10'
  spec.add_development_dependency 'rubocop-performance', '~> 1.9', '>= 1.9.2'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.2'
  spec.add_development_dependency 'simplecov', '~> 0.21.2'
end
