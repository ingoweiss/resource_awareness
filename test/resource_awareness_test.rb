require File.join(File.dirname(__FILE__), 'test_helper')
 
class ResourceAwarenessTest < Test::Unit::TestCase
  
  def setup
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
  
  def test_resources_should_know_their_controller
    
  end
  
  private
  
  def assert_resource_known(resource_name, resource_class=Rails::Resource)
    assert_not_nil Rails.application.resources.find { |r| r.is_a?(resource_class) && r.name == resource_name }, "No resource with name #{resource_name} known"
  end
  
end