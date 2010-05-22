require 'rails/application'
require 'resource_awareness/resource_collection'

module ResourceAwareness
  module ApplicationExtensions
    def resources
      @resources ||= ResourceCollection.new
    end
  end
end

Rails::Application.send(:include, ResourceAwareness::ApplicationExtensions)