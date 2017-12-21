class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy]

  def index
    @courses = Course.ordered_by_year.page(params[:page])
    check_pagination(@courses)
  end

  def show
    @examinations = @course.examinations
    @students = @course.students
  end

  def new
    @course = Course.new
    render(:form, locals: { title: :new_course })
  end

  def edit
    if @course.examinations.empty?
      render(:form, locals: { title: :edit_course })
    else
      redirect_to(courses_url, alert: t(:has_examinations))
    end
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
    if @course.errors.empty?
      redirect_to(courses_url, notice: t(:destroyed_course))
    else
      redirect_to(courses_url, alert: t(:not_destroyed_course))
    end
  end

  private
  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:year)
  end
end
