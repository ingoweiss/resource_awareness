require 'action_dispatch/routing/mapper'
require 'rails/resource'
require 'rails/singleton_resource'

module ResourceAwareness
  module MapperExtensions
    
    def resources(*entities, &block)
      super
      options = entities.extract_options!
      return unless leaf_call?(entities, options)
      Rails.application.resources << Rails::Resource.new(entities.first, @scope, options)
    end
    
    def resource(*entities, &block)
      super
      options = entities.extract_options!
      return unless leaf_call?(entities, options)
      Rails.application.resources << Rails::SingletonResource.new(entities.first, @scope, options)
    end
    
    private
    
    # the resource(s) methods call themselves recursively in certain conditions
    # (see the Mapper#apply_common_behavior_for method for details)
    # this method returns true only if this is a 'leaf call' (a call that doesn't call itself again)
    def leaf_call?(entities, options)
      return false if @scope[:scope_level] == :resources
      return false if entities.length > 1
      return false if options[:path_names]
      true
    end
    
  end
end

ActionDispatch::Routing::Mapper.send(:include, ResourceAwareness::MapperExtensions)