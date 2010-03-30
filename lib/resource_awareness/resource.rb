module Rails
  class Resource
    
    attr_accessor :name
    
    def initialize(entity, scope, options)
      @name = [scope[:name_prefix], entity].compact.join('_').to_sym
    end
    
  end
end