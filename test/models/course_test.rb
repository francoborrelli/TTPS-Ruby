require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  test 'should not be valid a course without year' do
    assert_not Course.new.valid?
  end

  test 'should not be valid a course when year is invalid' do
    # float
    course = Course.new(year: 20.17)
    assert_not course.valid?

    # string
    course.year = 'test'
    assert_not course.valid?

    # negative
    course.year = -2017
    assert_not course.valid?

    course.year = 2018
    assert course.valid?
  end

  test 'should not be valid a course when exists another with the same year' do
    course_one = courses(:one)
    course_two = course_one.dup
    assert_not course_two.valid?
  end

  test 'should not destroy course if it has students or examinations' do
    assert_not courses(:one).destroy
    assert courses(:three).destroy
  end
end
