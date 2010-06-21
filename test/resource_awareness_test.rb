require File.join(File.dirname(__FILE__), 'test_helper')

class ResourceAwarenessTest < Test::Unit::TestCase

  def setup
  end

  def test_resources_should_be_known
    assert_equal 4, Rails.application.resource_definitions.length
    assert_resource_known 'posts'
    assert_resource_known 'post_comments'
    assert_singleton_resource_known 'post_approval'
    assert_resource_known 'admin_comments'
  end

  def test_resources_should_know_their_controller_path
    assert_equal 'posts',          find_resource('posts').controller_path
    assert_equal 'post_comments',  find_resource('post_comments').controller_path
    assert_equal 'post_approval',  find_singleton_resource('post_approval').controller_path
    assert_equal 'admin/comments', find_resource('admin_comments').controller_path
  end

  def test_resources_should_know_their_controller
    assert_equal PostsController,           find_resource('posts').controller
    assert_equal PostCommentsController,    find_resource('post_comments').controller
    assert_equal PostApprovalController,    find_singleton_resource('post_approval').controller
    assert_equal Admin::CommentsController, find_resource('admin_comments').controller
  end

  def test_controllers_should_know_their_resource
    assert_equal find_resource('posts'),                    PostsController.new.resource_definition
    assert_equal find_resource('post_comments'),            PostCommentsController.new.resource_definition
    assert_equal find_singleton_resource('post_approval'),  PostApprovalController.new.resource_definition
    assert_equal find_resource('admin_comments'),           Admin::CommentsController.new.resource_definition
  end

  def test_resources_should_know_their_name_prefix
    assert_equal nil,     find_resource('posts').name_prefix
    assert_equal 'post',  find_resource('post_comments').name_prefix
    assert_equal 'post',  find_singleton_resource('post_approval').name_prefix
    assert_equal 'admin', find_resource('admin_comments').name_prefix
  end
  
  def test_resources_should_know_their_path_prefix
    assert_equal nil,                find_resource('posts').path_prefix
    assert_equal '/posts/:post_id',  find_resource('post_comments').path_prefix
    assert_equal '/posts/:post_id',  find_singleton_resource('post_approval').path_prefix
    assert_equal '/admin',           find_resource('admin_comments').path_prefix
  end

  def test_resources_should_know_their_path
    assert_equal '/posts',                    find_resource('posts').path
    assert_equal '/posts/:post_id/comments',  find_resource('post_comments').path
    assert_equal '/posts/:post_id/approval',  find_singleton_resource('post_approval').path
    assert_equal '/admin/comments',           find_resource('admin_comments').path
  end

  def test_resources_should_know_their_prefix_parameters
    assert_equal Set[],                    find_resource('posts').prefix_parameters
    assert_equal Set[:post_id],            find_resource('post_comments').prefix_parameters
    assert_equal Set[:post_id],            find_singleton_resource('post_approval').prefix_parameters
    assert_equal Set[],                    find_resource('admin_comments').prefix_parameters
  end

  def test_resources_should_know_whether_they_are_a_singleton
    assert_equal false, find_resource('posts').singleton?
    assert_equal false, find_resource('post_comments').singleton?
    assert_equal true,  find_singleton_resource('post_approval').singleton?
    assert_equal false, find_resource('admin_comments').singleton?
  end
  
  def test_resource_should_have_an_xml_representation
    assert_equal 'posts',           Nokogiri::XML(find_resource('posts').to_xml).xpath('/resource/id').text
    assert_equal 'post_comments',   Nokogiri::XML(find_resource('post_comments').to_xml).xpath('/resource/id').text
    assert_equal 'post_approval',   Nokogiri::XML(find_resource('post_approval').to_xml).xpath('/resource/id').text
    assert_equal 'admin_comments',  Nokogiri::XML(find_resource('admin_comments').to_xml).xpath('/resource/id').text
  end
  
  def test_resources_should_be_findable_by_id_using_bracket_syntax
    assert_equal find_resource('posts'), Rails.application.resource_definitions['posts']
    assert_equal find_resource('post_comments'), Rails.application.resource_definitions['post_comments']
    assert_equal find_resource('post_approval'), Rails.application.resource_definitions['post_approval']
    assert_equal find_resource('admin_comments'), Rails.application.resource_definitions['admin_comments']
  end

  private

  def assert_resource_known(resource_id, resource_class=Rails::Resource)
    assert_not_nil find_resource(resource_id, resource_class), "No resource with id #{resource_id} known"
  end

  def assert_singleton_resource_known(resource_id)
    assert_resource_known(resource_id, Rails::SingletonResource)
  end

  def find_resource(resource_id, resource_class=Rails::Resource)
    Rails.application.resource_definitions.find { |r| r.is_a?(resource_class) && r.id == resource_id }
  end

  def find_singleton_resource(resource_id)
    find_resource(resource_id, Rails::SingletonResource)
  end

end