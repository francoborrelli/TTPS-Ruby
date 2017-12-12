require 'test_helper'

class ExaminationsControllerTest < ActionController::TestCase
  setup do
    @course = courses(:one)
    @examination = examinations(:one)
  end

  test "should get index" do
    get :index, params: { course_id: @course }
    assert_response :success
  end

  test "should get new" do
    get :new, params: { course_id: @course }
    assert_response :success
  end

  test "should create examination" do
    assert_difference('Examination.count') do
      post :create, params: { course_id: @course, examination: @examination.attributes }
    end

    assert_redirected_to course_examination_path(@course, Examination.last)
  end

  test "should show examination" do
    get :show, params: { course_id: @course, id: @examination }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { course_id: @course, id: @examination }
    assert_response :success
  end

  test "should update examination" do
    put :update, params: { course_id: @course, id: @examination, examination: @examination.attributes }
    assert_redirected_to course_examination_path(@course, Examination.last)
  end

  test "should destroy examination" do
    assert_difference('Examination.count', -1) do
      delete :destroy, params: { course_id: @course, id: @examination }
    end

    assert_redirected_to course_examinations_path(@course)
  end
end
