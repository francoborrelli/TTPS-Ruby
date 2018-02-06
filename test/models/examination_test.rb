require 'test_helper'

class ExaminationTest < ActiveSupport::TestCase
  def setup
    @examination = examinations(:one)
  end

  test 'shouldnt be valid an examination with missing attributes' do
    assert_not Examination.new.valid?
  end

  test 'date should be inside the range' do
    @examination.date = '2016-03-04'
    assert_not @examination.valid?

    @examination.date = '2019-05-05'
    assert_not @examination.valid?

    @examination.date = '2017-03-04'
    assert @examination.valid?
  end

  test 'should standarize title' do
    @examination.title = 'este TiTuLO'
    @examination.save
    assert_equal('Este Titulo', @examination.title)
  end

  #Testing Uniqueness

  test 'should not be two exams with the same title in the same course' do
    examination_two = examinations(:three)
    examination_two.title = @examination.title
    assert_not examination_two.valid?
  end

  # Testing interactions with other models

  test 'should assert number of passing students' do
    assert_equal(0, @examination.passing_students)

    @examination.scores.build(score: 100, student: students(:two))
    @examination.scores.build(score: 1, student: students(:three))

    assert_equal(1, @examination.passing_students)
  end

  test 'should assert number of failed students' do
    assert_equal(1, @examination.failed_students)

    @examination.scores.build(score: 1, student: students(:three))
    assert_equal(2, @examination.failed_students)
  end

  test 'should assert number of absent students' do
    assert_equal(2, @examination.absent_students)

    @examination.scores.build(score: 1, student: students(:two))
    assert_equal(1, @examination.absent_students)

    @examination.scores.build(score: 1, student: students(:three))
    assert_equal(0, @examination.absent_students)
  end

  test 'should assert average of passing students' do
    assert_equal(0, @examination.passing_percentage)

    @examination.scores.build(score: 100, student: students(:two))
    @examination.scores.build(score: 95, student: students(:three))

    result = 200 / 3.to_f
    assert_equal(result, @examination.passing_percentage)
  end

  test 'should not destroy examination if it has scores' do
    assert_not @examination.destroy
    assert examinations(:two).destroy
  end
end
