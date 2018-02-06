require 'test_helper'

class ScoreTest < ActiveSupport::TestCase
  def setup
    @score = scores(:one)
  end

  test 'should not be valid an empty score' do
    assert_not Score.new.valid?
  end

  test 'should not exists two scores for the same student in the same examination' do
    score_two = @score.dup
    score_two.score = 10
    assert_not score_two.valid?
  end

  test 'score should be within the range 0..100' do
    @score.score = -1
    assert_not @score.valid?

    @score.score = 101
    assert_not @score.valid?

    @score.score = 0
    assert @score.valid?

    @score.score = 100
    assert @score.valid?
  end

  test 'should know if student passed exam' do
    assert_not @score.passed?

    assert scores(:two).passed?
  end

end
