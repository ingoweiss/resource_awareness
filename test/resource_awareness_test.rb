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
    assert_equal 'posts',          find_resource('posts').controller_name
    assert_equal 'post_comments',  find_resource('post_comments').controller_name
    assert_equal 'post_approval',  find_resource('post_approval').controller_name
  end

  def test_controllers_should_know_their_resource
    assert_equal find_resource('posts'),          PostsController.new.resource
    assert_equal find_resource('post_comments'),  PostCommentsController.new.resource
    assert_equal find_resource('post_approval'),  PostApprovalController.new.resource
  end

  def test_resources_should_know_their_name_prefix
    assert_equal nil,     find_resource('posts').name_prefix
    assert_equal 'post',  find_resource('post_comments').name_prefix
    assert_equal 'post',  find_resource('post_approval').name_prefix
  end
  
  def test_resources_should_know_their_path_prefix
    assert_equal nil,               find_resource('posts').path_prefix
    assert_equal '/posts/:post_id',  find_resource('post_comments').path_prefix
    assert_equal '/posts/:post_id',  find_resource('post_approval').path_prefix
  end

  def test_resources_should_know_their_path
    assert_equal '/posts',                    find_resource('posts').path
    assert_equal '/posts/:post_id/comments',  find_resource('post_comments').path
    assert_equal '/posts/:post_id/approval',  find_resource('post_approval').path
  end

  private

  def assert_resource_known(resource_id, resource_class=Rails::Resource)
    assert_not_nil find_resource(resource_id, resource_class), "No resource with id #{resource_id} known"
  end

  def assert_singleton_resource_known(resource_id)
    assert_resource_known(resource_id, Rails::SingletonResource)
  end

  def find_resource(resource_id, resource_class=Rails::Resource)
    Rails.application.resources.find { |r| r.is_a?(resource_class) && r.id == resource_id }
  end

end