require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  test 'should not save course without year' do
    course = Course.new
    assert_not course.save
  end

  test 'should not save course with a year number with less than 4 digits' do
    course = Course.new(year: 20);
    assert_not course.save
  end

  test 'should not save course with a year number with more than 4 digits' do
    course = Course.new(year: 20170);
    assert_not course.save
  end

  test 'should no save course if year is not integer' do
    course = Course.new(year: 20.17);
    assert_not course.save
  end

  test 'should not save course with no numerical year' do
    course = Course.new(year: "test");
    assert_not course.save
  end

  test 'should save course with valid year' do
    assert Course.create(year: 2017)
  end

  test 'should not save course when exists another with the same year' do
    course_one = courses(:one)
    course_two = course_one.dup
    assert course_one.save
    assert_not course_two.save
  end

  test 'should not have students when created' do
    course = courses(:three)
    assert_empty course.students
  end

  test 'should not have examinations when created' do
    course = courses(:three)
    assert_empty course.examinations
  end

  test 'should have two student' do
    course = courses(:one)
    student_one = students(:one)
    student_two = students(:two)
    student_three = students(:three)
    assert_equal(3, course.students.size)
    assert_includes(course.students, student_one)
    assert_includes(course.students, student_two)
    assert_includes(course.students, student_three)
  end

  test 'should have two examination' do
    course = courses(:one)
    exam_one = examinations(:one)
    exam_two = examinations(:three)
    assert_equal(2, course.examinations.size)
    assert_includes(course.examinations, exam_one)
    assert_includes(course.examinations, exam_two)
  end
end
