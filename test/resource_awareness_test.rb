require File.join(File.dirname(__FILE__), 'test_helper')
 
class ResourceAwarenessTest < Test::Unit::TestCase
  
  def setup
  end
  
  def test_resources_should_be_known
    assert_equal 3, Rails.application.resources.length
    assert_resource_known 'posts'
    assert_resource_known 'post_comments'
    assert_resource_known 'post_approval'
  end
  
  private
  
  def assert_resource_known(resource_name, resource_class=Rails::Resource)
    assert_not_nil Rails.application.resources.find { |r| r.is_a?(resource_class) && r.name == resource_name }, "No resource with name #{resource_name} known"
  end
  
  def assert_singleton_resource_known(resource_name)
    assert_resource_known(resource_name, Rails::SingletonResource)
  end
  
end