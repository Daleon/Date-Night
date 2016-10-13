require_relative 'binary_tree'
require_relative 'score_movie'

class Node
  attr_reader   :data

  attr_accessor :left,
                :right

  def initialize(movie_score, movie_name)
    @data = ScoreMovie.new(movie_score, movie_name)
    @left
    @right
  end

  def movie_score
    data.movie_score
  end

  def movie_name
    data.movie_name
  end

  def left_full?
    left.class == Node
  end

  def right_full?
    right.class == Node
  end

  def has_children?
    left_full? && right_full?
  end
end
