require 'builder'

module Rails
  class Resource
    attr_accessor :id, :name, :singular_name, :controller_path, :name_prefix, :path_prefix, :prefix_parameters, :home_route

    def initialize(entity, scope, options)
      self.name_prefix = scope[:as]
      self.name = entity.to_s
      self.singular_name = name.singularize
      self.id = [name_prefix, name].compact.join('_')
      self.home_route = Rails.application.routes.named_routes[id]
      self.path_prefix = home_route.path.sub("/#{name}(.:format)", '')
      self.path_prefix = nil if path_prefix.blank?
      self.prefix_parameters = home_route.segment_keys.find_all{|sk| sk.to_s.match(/_id\Z/)}.to_set
      self.controller_path = home_route.requirements[:controller]
    end
    
    def path
      path_prefix ? "#{path_prefix}/#{name}" : "/#{name}"
    end
    
    def controller
      @controller ||= (controller_path + '_controller').classify.constantize
    end
    
    def singleton?
      false
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
        xml.controller_path controller_path
      end
    end
  end
end