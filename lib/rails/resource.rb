module Rails
  class Resource
    
    attr_accessor :name, :controller
    
    def initialize(entity, scope, options)
      self.name = [scope[:name_prefix], entity].compact.join('_')
    end
    
    def controller
      @controller ||= (Rails.application.routes.named_routes[name].defaults[:controller] + '_controller').camelize.constantize
    end
    
  end
end