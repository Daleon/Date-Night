require_relative 'node'
require_relative 'score_movie'
require 'pry'

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root
  end

  def insert(movie_score, movie_name)
    if @root.nil?
      @root = Node.new(movie_score, movie_name)
    else
      traverse_insert(@root, movie_score, movie_name)
    end
    depth_of(movie_score)
  end

  def traverse_insert(node, movie_score, movie_name)
    if score_greater_than(node, movie_score) && node.left_full?
      traverse_insert(node.left, movie_score, movie_name)
    elsif score_less_than(node, movie_score) && node.right_full?
      traverse_insert(node.right, movie_score, movie_name)
    elsif score_greater_than(node, movie_score) && !node.left_full?
      node.left = Node.new(movie_score, movie_name)
    elsif score_less_than(node, movie_score) && !node.right_full?
      node.right = Node.new(movie_score, movie_name)
    end
  end

  def score_greater_than(node, movie_score)
    node.movie_score > movie_score
  end

  def score_less_than(node, movie_score)
    node.movie_score < movie_score
  end

  def depth_of(movie_score)
    traverse_depth(@root, movie_score, 0)
  end

  def traverse_depth(node, movie_score, depth)
    if node.movie_score == movie_score
      return depth
    elsif score_greater_than(node, movie_score)
      traverse_depth(node.left, movie_score, depth += 1)
    elsif score_less_than(node, movie_score)
      traverse_depth(node.right, movie_score, depth += 1)
    end
  end

  def include?(movie_score, node=@root)
    if node.movie_score == movie_score
      return true
    elsif score_greater_than(node, movie_score)
      return false unless node.left_full?
      include?(movie_score, node.left)
    elsif node.movie_score < movie_score
      return false unless node.right_full?
      include?(movie_score, node.right)
    end
  end

  def max(node=@root)
    if node.right_full?
      max(node.right)
    else
      {node.movie_name => node.movie_score}
    end
  end

  def min(node=@root)
    if node.left_full?
      min(node.left)
    else
      {node.movie_name => node.movie_score}
    end
  end

  def sort
    sort_nodes.map do |node_depth|
      node = node_depth[:node]
      {node.movie_name => node.movie_score}
    end
  end

  def sort_nodes
    all.sort_by do |node_depth|
      node_depth[:node].movie_score
    end
  end

  def load(file_name)
    File.open(file_name, "r") do |file|
      file.each_line do |line|
        movie_score = line.chomp.split(", ")
        insert(movie_score[0], movie_score[1])
      end
    end
    all.length
  end

  def health(depth)
    get_nodes_at_depth(depth).map do |node|
      [node.movie_score,
       count_nodes_at_and_below_node_with_score(node.movie_score),
       percent_of_tree_below_node_with_score(node.movie_score)]
     end
  end

  def get_nodes_at_depth(depth)
    all.reduce([]) do |nodes, node_depth|
      if node_depth[:depth] == depth
        nodes << node_depth[:node]
      end
      nodes
    end
  end

  def count_nodes_at_and_below_node_with_score(movie_score)
    all(find_node_with_score(movie_score)).count
  end

  def percent_of_tree_below_node_with_score(movie_score)
    ((count_nodes_at_and_below_node_with_score(movie_score) / all.count.to_f) * 100).to_i
  end

  def total
    all.count
  end

  def find_node_with_score(movie_score)
    all.find do |node_depth|
      node_depth[:node].movie_score == movie_score
    end[:node]
  end

  def all(node=@root, nodes_depth=[{:node => @root, :depth => 0}])
    if node.left_full?
      nodes_depth << {:node => node.left, :depth => depth_of(node.left.movie_score)}
      all(node.left, nodes_depth)
    end
    if node.right_full?
      nodes_depth << {:node => node.right, :depth => depth_of(node.right.movie_score)}
      all(node.right, nodes_depth)
    end
    return nodes_depth
  end
end
