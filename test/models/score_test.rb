require 'test_helper'

class ScoreTest < ActiveSupport::TestCase
  def setup 
    @score = scores(:one)
  end

  test 'should not save score if it does not have a student' do
    @score.student = nil
    assert_not @score.save
  end

  test 'should not save score if it does not have an examination' do
    @score.examination = nil
    assert_not @score.save
  end

  test 'should not exists two scores with the same student for the same examination' do
    score_two = @score.dup
    score_two.score = 10
    assert_not score_two.save
  end

  test 'should save score if valid' do
    assert @score.save
  end

  test 'score should not be smaller than 0' do
    @score.score = -21
    assert_not @score.save
  end

  test 'score should not be bigger than 100' do
    @score.score = 210
    assert_not @score.save
  end

  test 'score should be a number' do
    @score.score = "test"
    assert_not @score.save
  end

  test 'should know if student passed exam' do
    assert_not @score.passed?

    score_two = scores(:two)
    assert score_two.passed?
  end
end
