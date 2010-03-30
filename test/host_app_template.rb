append_file 'Gemfile', "gem 'ruby-debug'\n"
append_file 'Gemfile', "gem 'resource_awareness', :path => '#{ENV['RESOURCE_AWARENESS_ROOT']}'\n"

route <<-ROUTES
  resources :posts do
    resources :comments
    resource :approval
  end
ROUTES