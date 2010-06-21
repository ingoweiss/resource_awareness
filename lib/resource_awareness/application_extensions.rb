require 'rails/application'
require 'resource_awareness/resource_collection'

module ResourceAwareness
  module ApplicationExtensions
    def resource_definitions
      @resource_definitions ||= ResourceCollection.new
    end
  end
end

Rails::Application.send(:include, ResourceAwareness::ApplicationExtensions)