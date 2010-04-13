module Rails
  class Resource
    
    attr_accessor :name, :singular_name, :id, :route, :controller_name, :controller, :name_prefix
    
    def initialize(entity, scope, options)
      self.name_prefix = scope[:name_prefix]
      self.name = entity.to_s
      self.singular_name = name.singularize
      self.id = [name_prefix, name].compact.join('_')
      self.route = Rails.application.routes.named_routes[id]
      self.controller_name = route.defaults[:controller]
      self.controller = (controller_name + '_controller').camelize.constantize
    end
    
  end
end