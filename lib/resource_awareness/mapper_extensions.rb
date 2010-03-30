require 'action_dispatch/routing/mapper'
require 'resource_awareness/resource'
require 'resource_awareness/singleton_resource'

module ResourceAwareness
  module MapperExtensions
    
    def resources(*entities, &block)
      super
      return if @scope[:scope_level] == :resources
      options = entities.extract_options!
      entity = entities.first
      Rails.application.resources << Rails::Resource.new(entity, @scope, options)
    end
    
    def resource(*entities, &block)
      super
      return if @scope[:scope_level] == :resources
      options = entities.extract_options!
      entity = entities.first
      Rails.application.resources << Rails::SingletonResource.new(entity, @scope, options)
    end
    
  end
end

ActionDispatch::Routing::Mapper.send(:include, ResourceAwareness::MapperExtensions)