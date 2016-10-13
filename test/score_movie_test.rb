require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/score_movie'

class ScoreMovieTest < Minitest::Test
  
  def test_can_create_a_movie_and_score
    score_movie = ScoreMovie.new(61, "Bill & Ted's Excellent Adventure")
    assert ScoreMovie, score_movie.class
  end

  def test_can_get_score
    score_movie = ScoreMovie.new(61, "Bill & Ted's Excellent Adventure")
    assert_equal 61, score_movie.movie_score
  end

  def test_can_get_name_of_movie
    score_movie = ScoreMovie.new(61, "Bill & Ted's Excellent Adventure")
    assert_equal "Bill & Ted's Excellent Adventure", score_movie.movie_name
  end
end
