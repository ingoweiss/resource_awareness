require 'builder'

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
    
    def to_xml(options = {})
      options[:indent] ||= 2
      xml = options[:builder] ||= Builder::XmlMarkup.new(:indent => options[:indent])
      xml.instruct! unless options[:skip_instruct]
      xml.resource do
        xml.id id
        xml.type self.class
        xml.name name
        xml.singular_name singular_name
        xml.path_prefix path_prefix
        xml.path path
        xml.controller_name controller_name
      end
    end
  end
end