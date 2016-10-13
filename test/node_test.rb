require 'minitest/autorun'
require 'minitest/pride'
require '../lib/binary_tree'
require '../lib/node'
require '../lib/score_movie'

class NodeTest < Minitest::Test

  def test_can_create_a_new_node_instance_object
    node = Node.new(16, "Johnny English")
    assert Node, node.class
  end

  def test_can_get_score_from_node
    node = Node.new(16, "Johnny English")
    assert_equal 16, node.movie_score
  end

  def test_can_get_movie_title_from_node
    node = Node.new(16, "Johnny English")
    assert_equal "Johnny English", node.movie_name
  end

  def test_can_create_a_node_with_rating_and_title
    node = Node.new(16, "Johnny English")
    assert_equal 16, node.movie_score
    assert_equal "Johnny English", node.movie_name
  end

  def test_left_and_right_are_nil
    node = Node.new(16, "Johnny English")
    assert_equal nil, node.left
    assert_equal nil, node.right
  end
end
