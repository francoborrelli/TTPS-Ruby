require 'test_helper'

class ExaminationTest < ActiveSupport::TestCase
  def setup
    @examination = examinations(:one)
  end

  test 'shouldnt save empty examination' do
    examination = Examination.new
    assert_not examination.save
  end

  # min_score
  test 'shouldnt save if min_score is a string' do
    @examination.min_score = 'hola'
    assert_not @examination.save
  end

  test 'shouldnt save if min_score is nil' do
    @examination.min_score = nil
    assert_not @examination.save
  end

  test 'shouldnt save if min_score smaller than 0' do
    @examination.min_score = -1
    assert_not @examination.save
  end

  test 'shouldnt save if min_score bigger than 100' do
    @examination.min_score = 100.1
    assert_not @examination.save
  end

  test 'should save if min_score valid' do
    @examination.min_score = 10.01
    assert @examination.save

    @examination.min_score = 10
    assert @examination.save
  end

  # title
  test 'should not save if it has no title' do
    @examination.title = nil
    assert_not @examination.save
  end

  test 'should not be two exams with the same title in the same course' do
    examination_two = examinations(:three)
    examination_two.title = @examination.title

    assert_not examination_two.save
  end

  # date
  test 'should not save if it has no date' do
    @examination.date = nil
    assert_not @examination.save
  end

  # testing interactions with other models
  test 'should assert number of passing students' do
    assert_equal(0, @examination.passing_students)

    student = students(:two)
    @examination.scores.build(score: 100, student: student)
    assert_equal(1, @examination.passing_students)

    student = students(:three)
    @examination.scores.build(score: 1, student: student)
    assert_equal(1, @examination.passing_students)
  end

  test 'should assert number of failed students' do
    assert_equal(1, @examination.failed_students)

    student = students(:two)
    @examination.scores.build(score: 100, student: student)
    assert_equal(1, @examination.failed_students)

    student = students(:three)
    @examination.scores.build(score: 1, student: student)
    assert_equal(2, @examination.failed_students)
  end

  test 'should assert number of absent students' do
    assert_equal(2, @examination.absent_students)

    student = students(:two)
    @examination.scores.build(score: 1, student: student)
    assert_equal(1, @examination.absent_students)

    student = students(:three)
    @examination.scores.build(score: 1, student: student)
    assert_equal(0, @examination.absent_students)
  end

  test 'should assert average of passing students' do
    assert_equal(0, @examination.passing_percentage)

    student = students(:two)
    @examination.scores.build(score: 100, student: student)

    result = 100 / 3.to_f
    assert_equal(result, @examination.passing_percentage)

    student = students(:three)
    @examination.scores.build(score: 95, student: student)

    result = 200 / 3.to_f
    assert_equal(result, @examination.passing_percentage)
  end
end
