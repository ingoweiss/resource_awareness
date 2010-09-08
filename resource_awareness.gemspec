Gem::Specification.new do |gem|
  gem.name    = 'resource_awareness'
  gem.version = '0.2.2'
  gem.summary = "Makes Rails applications aware of their resources"
  gem.description = <<-DESCRIPTION
Makes information about a Rails application's resources (as defined via the 'resource(s)' routing DSL methods) available via Rails.application.resources
DESCRIPTION
  gem.authors = ['Ingo Weiss']
  gem.email = 'ingo@ingoweiss.com'
  gem.homepage = 'http://github.com/ingoweiss/resource_awareness'
  gem.files = Dir['{lib}/**/*']
  gem.add_dependency 'rails', '3.0.0'
  gem.add_dependency 'builder', '~> 2.1'
end