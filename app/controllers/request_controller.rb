class RequestController < ApplicationController
  before_action :set_course, :set_examination

  def get_students
    render json: (@course.students.reject { |student| student.took_exam?(@examination) })
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_examination
    @examination = @course.examinations.find(params[:id])
  end
end
