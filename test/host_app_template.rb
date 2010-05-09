gem 'ruby-debug'
gem 'resource_awareness', :path => ENV['RESOURCE_AWARENESS_ROOT']
gem 'nokogiri'

route <<ROUTES
resources :posts do
  resources :comments, :controller => 'post_comments'
  resource :approval, :controller => 'post_approval'
end
namespace :admin do
  resources :comments
end
ROUTES
generate :controller, 'posts'
generate :controller, 'post_comments'
generate :controller, 'post_approval'
generate :controller, 'admin/comments'