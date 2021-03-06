require 'action_dispatch/routing/mapper'
require 'rails/resource'
require 'rails/singleton_resource'

module ResourceAwareness
  module MapperExtensions
    def resources(*entities, &block)
      super
      options = entities.extract_options!
      Rails.application.resource_definitions << Rails::Resource.new(entities.first, @scope, options) if leaf_call?(entities, options)
    end

    def resource(*entities, &block)
      super
      options = entities.extract_options!
      Rails.application.resource_definitions << Rails::SingletonResource.new(entities.first, @scope, options) if leaf_call?(entities, options)
    end

    private

    # the resource(s) methods call themselves recursively in certain conditions
    # (see the Mapper#apply_common_behavior_for method for details)
    # this method returns true only if this is a 'leaf call' (a call that doesn't call itself again)
    # TODO: there should be a better way to determine this
    def leaf_call?(entities, options)
      return false if entities.many?
      return false unless options.slice!(*ActionDispatch::Routing::Mapper::RESOURCE_OPTIONS).empty?
      return false if options[:path_names]
      return false if [:resource, :resources].include?(@scope[:scope_level])
      true
    end
  end
end

ActionDispatch::Routing::Mapper.send(:include, ResourceAwareness::MapperExtensions)