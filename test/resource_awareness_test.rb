require File.join(File.dirname(__FILE__), 'test_helper')
require File.join(File.dirname(__FILE__), 'host_app_helper')

 
class ResourceAwarenessTest < Test::Unit::TestCase
  
  include HostAppHelper
  
  def setup
    recreate_host_app
    load_host_app
  end
  
  def test_post_resource_should_be_known
    assert_resource_known 'posts'
  end
  
  def test_post_comments_resource_should_be_known
    assert_resource_known 'post_comments'
  end
  
  def test_post_approval_resource_should_be_known
    assert_resource_known 'post_approval'
  end
  
  private
  
  def assert_resource_known(resource_name, resource_class=Rails::Resource)
    assert_not_nil Rails.application.resources.find { |r| r.is_a?(resource_class) && r.name == resource_name }, "No resource with name #{resource_name} known"
  end
  
end