require 'resource_awareness'
require 'rails'

module ResourceAwareness
  class Railtie < Rails::Railtie
    
    initializer 'resource_awareness.extend_application' do
      require 'resource_awareness/application_extensions'
    end
    
    initializer 'resource_awareness.extend_mapper' do
      require 'resource_awareness/mapper_extensions'
    end
    
  end
end