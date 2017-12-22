require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  setup do
    @student = students(:one)
  end

  # Testing Model

  test 'should not save empty student' do
    student = Student.new
    assert_not student.save
  end

  # DNI

  test 'should not save if dni is not present' do
    @student.dni = ''
    assert_not @student.save
  end

  test 'student dni should be unique in a course' do
    student_two = students(:two)
    student_two.dni = @student.dni
    assert_not student_two.save
  end

  test 'should not save if dni is not integer' do
    @student.dni = 'hola'
    assert_not @student.valid?

    @student.dni = '34hola'
    assert_not @student.valid?

    @student.dni = 243_434.3
    assert_not @student.valid?

    @student.dni = 39831172
    assert @student.valid?
  end

  test 'dni should have between 6 and 11 digits' do
    @student.dni = 1
    assert_not @student.valid?

    @student.dni = 111111111111
    assert_not @student.valid?
  end

  test 'dni should be positive' do
    @student.dni = -39831172
    assert_not @student.valid?
  end

  # Student Number

  test 'should not save if student number is not present' do
    @student.s_number = nil
    assert_not @student.save
  end

  test 'student number should be unique in a course' do
    student_two = students(:two)
    @student.s_number = student_two.s_number
    assert_not @student.save
  end

  test 'student number should be valid' do
    assert @student.valid?
    @student.s_number = '123123123'
    assert_not @student.valid?
    @student.s_number = '1231/'
    assert_not @student.valid?
    @student.s_number = '13732/5'
    assert @student.valid?
    @student.s_number = '12313/45'
    assert_not @student.valid?
  end

  # Email

  test 'email should be unique in a course' do
    student_two = students(:two)
    student_two.email = @student.email
    assert_not student_two.save
  end

  test 'should not save if email is not present' do
    @student.email = ''
    assert_not @student.save

    @student.email = 'francoborrelli@email.com'
    assert @student.save
  end

  test 'student email should be valid' do
    @student.email = '34r3'
    assert_not @student.valid?

    @student.email = '34r3@'
    assert_not @student.valid?

    @student.email = 'test@'
    assert_not @student.valid?

    @student.email = 'test.com'
    assert_not @student.valid?

    @student.email = 'test@c.com'
    assert @student.valid?
  end

  # Name

  test 'student name should be present' do
    @student.name = ''
    assert_not @student.save
    @student.name = 'franco'
    assert @student.save
  end

  test 'student name should be standarize' do
    @student.name = 'FRANCO'
    @student.save
    assert_equal('Franco', @student.name)
    @student.name = 'franco'
    @student.save
    assert_equal('Franco', @student.name)
    @student.name = 'Franco'
    @student.save
    assert_equal('Franco', @student.name)
  end

  # Surname

  test 'student surname should be present' do
    @student.surname = ''
    assert_not @student.save
    @student.surname = 'Borrelli'
    assert @student.save
  end

  test 'student surname should be standarize' do
    @student.name = 'BORRELLI'
    @student.save
    assert_equal('Borrelli', @student.surname)
  end

  # Full name

  test 'should return student full name' do
    assert_equal('Franco Borrelli', @student.full_name)
  end

  # testing interactions with other models

  test 'should have taken the exam' do
    exam = examinations(:one)
    assert @student.took_exam?(exam)
  end

  test 'should not have taken the exam' do
    exam = examinations(:two)
    assert_not @student.took_exam?(exam)
  end

  test 'should know the exam for the exam' do
    exam = examinations(:one)
    score = scores(:one)
    assert_equal(score, @student.score_for_exam(exam))
  end

  test 'should have one score' do
    assert_equal(1, @student.scores.size)
  end

  test 'should be in course one' do
    course_one = courses(:one)
    course_two = courses(:two)
    assert_equal(course_one, @student.course)
    assert_not_equal(course_two, @student.course)
  end

  test 'should be in a course' do
    @student.course = nil
    assert_not @student.save
  end

  test 'should not destroy student if it has scores' do
    assert_not @student.destroy
    assert students(:three).destroy
  end
end
