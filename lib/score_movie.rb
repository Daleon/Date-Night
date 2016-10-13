require_relative 'node'
require_relative 'binary_tree'


class ScoreMovie
  attr_reader :movie_score,
              :movie_name

  def initialize(movie_score, movie_name)
    @movie_score = movie_score
    @movie_name = movie_name
  end
end
