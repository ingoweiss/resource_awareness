module ResourceAwareness
  class ResourceCollection < Array
  
    def [](identifier)
      find { |r| r.id == identifier }
    end
  
  end
end