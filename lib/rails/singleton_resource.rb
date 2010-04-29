require 'rails/resource'
module Rails
  class SingletonResource < Resource
    
    def singleton?
      true
    end
    
  end
end