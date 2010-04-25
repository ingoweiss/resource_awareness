require 'rails/application'

module ResourceAwareness
  module ApplicationExtensions
    def resources
      @resources ||= []
    end
  end
end

Rails::Application.send(:include, ResourceAwareness::ApplicationExtensions)