require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  setup do
    @student = students(:one)
  end

  # Testing Model
  
  test 'shouldnt be valid a student with missing attributes' do
    assert_not Student.new.valid?
  end

  # Testing uniqueness

  test 'student dni should be unique in a course' do
    @student.dni = students(:two).dni
    assert_not @student.valid?
  end

  test 'email should be unique in a course' do
    @student.email = students(:two).email
    assert_not @student.valid?
  end

  test 'student number should be unique in a course' do
    @student.s_number = students(:two).s_number
    assert_not @student.valid?
  end

  # Testing Format

  test 'student number should have correct format' do
    @student.s_number = '123123123'
    assert_not @student.valid?
    @student.s_number = '1231/'
    assert_not @student.valid?
    @student.s_number = '12313/45'
    assert_not @student.valid?
    @student.s_number = '13732/5'
    assert @student.valid?
  end

  test 'student email should have correct format' do
    @student.email = '34r3'
    assert_not @student.valid?
    @student.email = '34r3@'
    assert_not @student.valid?
    @student.email = 'test.com'
    assert_not @student.valid?

    @student.email = 'test@c.com'
    assert @student.valid?
  end

  # Testing Standarization 

  test 'student name should be standarize' do
    @student.name = 'franco'
    @student.save
    assert_equal('Franco', @student.name)
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

  # Testing interactions with other models

  test 'should know if it took the exam' do
    assert @student.took_exam?(examinations(:one))

    assert_not @student.took_exam?(examinations(:two))
  end

  test 'should not destroy student if it has scores' do
    assert_not @student.destroy
    assert students(:three).destroy
  end
end
