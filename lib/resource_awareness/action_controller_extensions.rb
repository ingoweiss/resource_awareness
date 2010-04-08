require 'action_controller/base'

class ActionController::Base
  class << self
    
    def resource
      @resource ||= Rails.application.resources.find { |r| r.controller == self }
    end
    
  end
end
