module Rails
  class Resource
    attr_accessor :id, :name, :singular_name, :controller_name, :name_prefix, :path_prefix, :home_route

    def initialize(entity, scope, options)
      self.name_prefix = scope[:name_prefix]
      self.name = entity.to_s
      self.singular_name = name.singularize
      self.id = [name_prefix, name].compact.join('_')
      self.home_route = Rails.application.routes.named_routes[id]
      self.path_prefix = home_route.path.sub("/#{name}(.:format)", '')
      self.path_prefix = nil if path_prefix.blank?
      self.controller_name = home_route.requirements[:controller]
    end
    
    def path
      path_prefix ? "#{path_prefix}/#{name}" : "/#{name}"
    end
    
    def attributes
      {
        :id => id,
        :name => name,
        :singular_name => singular_name,
        :path_prefix => path_prefix,
        :path => path,
        :controller_name => controller_name
      }
    end
    
    def to_xml
      attributes.to_xml
    end
  end
end