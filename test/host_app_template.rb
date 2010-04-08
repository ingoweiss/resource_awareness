gem 'ruby-debug'
gem 'resource_awareness', :path => ENV['RESOURCE_AWARENESS_ROOT']
gem 'relay'
gem 'ingoweiss_generators'

add_file 'config/resource_layout.rb', <<RESOURCE_LAYOUT
ResourceLayout.define do
  many :posts do
    many :comments
    one :approval
  end
end
RESOURCE_LAYOUT
generate :resource_layout, '--generator=ingoweiss:scaffold'