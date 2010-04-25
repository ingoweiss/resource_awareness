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

    initializer 'resource_awareness.extend_action_controller' do
      require 'resource_awareness/action_controller_extensions'
    end

    rake_tasks do
      load 'tasks/resource_awareness.rake'
    end

  end
end