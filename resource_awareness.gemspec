Gem::Specification.new do |gem|
  gem.name    = 'resource_awareness'
  gem.version = '0.0.1'
  gem.summary = "Make Rails aware of it's resources"
  gem.description = <<-DESCRIPTION
Makes a Rails application's resources (as defined via the 'resource(s)' routing DSL methods) available as Rails.application.resources
DESCRIPTION
  gem.authors = ['Ingo Weiss']
  gem.email = 'ingo@ingoweiss.com'
  gem.homepage = 'http://www.ingoweiss.com'
  gem.rubyforge_project = '[none]'

  gem.files = Dir['{lib}/**/*']
  gem.add_dependency 'rails', '3.0.0.beta2'
end