require_relative '../lib/binary_tree'
require_relative '../lib/score_movie'
require_relative '../lib/node'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'


class NodeTest < Minitest::Test
  def test_tree_object_exists
    tree = BinarySearchTree.new
    assert_equal BinarySearchTree, tree.class
  end

  def test_can_insert_into_tree
    tree = BinarySearchTree.new
    assert_equal 0, tree.insert(61, "Bill & Ted's Excellent Adventure")
    assert_equal 1, tree.insert(16, "Johnny English")
    assert_equal 1, tree.insert(92, "Sharknado 3")
    assert_equal 2, tree.insert(50, "Hannibal Buress: Animal Furnace")
  end

  def test_can_check_what_is_included_in_trees
    tree = BinarySearchTree.new
    assert_equal 0, tree.insert(61, "Bill & Ted's Excellent Adventure")
    assert_equal 1, tree.insert(16, "Johnny English")
    assert_equal 1, tree.insert(92, "Sharknado 3")
    assert_equal 2, tree.insert(50, "Hannibal Buress: Animal Furnace")
    assert_equal true, tree.include?(16)
    assert_equal false, tree.include?(72)
  end

  def test_can_report_the_depth_where_a_score_appears
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "The Matrix")
    tree.insert(50, "Kung Fu Panda")
    assert_equal 0, tree.depth_of(61)
    assert_equal 1, tree.depth_of(92)
    assert_equal 1, tree.depth_of(16)
    assert_equal 2, tree.depth_of(50)
  end

  def test_can_find_movie_with_highest_score
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress: Animal Furnace")
    assert_equal ({"Sharknado 3" => 92}), tree.max
  end

  def test_min_can_find_movie_with_minimum_score
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress: Animal Furnace")
    assert_equal ({"Johnny English" => 16}), tree.min
  end

  def test_sort_returns_array_of_sorted_hashes
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress: Animal Furnace")
    assert_equal [{"Johnny English"=>16},
                  {"Hannibal Buress: Animal Furnace"=>50},
                  {"Bill & Ted's Excellent Adventure"=>61},
                  {"Sharknado 3"=>92}], tree.sort
  end

  def test_health_of_tree
    tree = BinarySearchTree.new
    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")
    assert_equal [[98, 7, 100]], tree.health(0)
    assert_equal [[58, 6, 85]], tree.health(1)
    assert_equal [[36, 2, 28], [93, 3, 42]], tree.health(2)
  end

  def test_can_load_movie_info_from_text_file
    tree = BinarySearchTree.new
    assert_equal 6, tree.load('../lib/movies.txt')
  end
end
