require 'action_controller/base'

class ActionController::Base
  def resource_definition
    @resource_definition ||= Rails.application.resource_definitions.find { |r| r.controller_path == self.controller_path }
  end
end
