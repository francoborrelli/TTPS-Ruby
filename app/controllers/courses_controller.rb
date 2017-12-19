class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy]

  def index
    @courses = Course.order('year DESC').page(params[:page])
    check_pagination(@courses)
  end

  def show
    @examinations = @course.examinations.order(:date)
    @students = @course.students.order('surname, name')
  end

  def new
    @course = Course.new
    render(:form, locals: { title: :new_course })
  end

  def edit
    render(:form, locals: { title: :edit_course })
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to(courses_url, notice: t(:created_course))
    else
      render(:form, locals: { title: :new_course })
    end
  end

  def update
    if @course.update(course_params)
      redirect_to(courses_url, notice: t(:updated_course))
    else
      render(:form, locals: { title: :edit_course })
    end
  end

  def destroy
    @course.destroy
    redirect_to(courses_url, notice: t(:destroyed_course))
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:year)
  end
end
