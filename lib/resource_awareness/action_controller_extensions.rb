require 'action_controller/base'

class ActionController::Base
  def resource
    @resource ||= Rails.application.resources.find { |r| r.controller_name == self.controller_name }
  end
end
