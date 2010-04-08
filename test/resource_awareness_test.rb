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
  
  def test_resources_should_know_their_controller
    assert_equal PostsController,         find_resource_by_name('posts').controller
    assert_equal PostCommentsController,  find_resource_by_name('post_comments').controller
    assert_equal PostApprovalController,  find_resource_by_name('post_approval').controller
  end
  
  def test_controllers_should_know_their_resource
    assert_equal find_resource_by_name('posts'),          PostsController.resource
    assert_equal find_resource_by_name('post_comments'),  PostCommentsController.resource
    assert_equal find_resource_by_name('post_approval'),  PostApprovalController.resource
  end
  
  private
  
  def assert_resource_known(resource_name, resource_class=Rails::Resource)
    assert_not_nil find_resource_by_name(resource_name, resource_class), "No resource with name #{resource_name} known"
  end
  
  def assert_singleton_resource_known(resource_name)
    assert_resource_known(resource_name, Rails::SingletonResource)
  end
  
  def find_resource_by_name(resource_name, resource_class=Rails::Resource)
    Rails.application.resources.find { |r| r.is_a?(resource_class) && r.name == resource_name }
  end
  
end