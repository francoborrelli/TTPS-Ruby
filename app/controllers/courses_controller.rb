class CoursesController < ApplicationController
  before_action :set_course,  only: [:show, :edit, :update, :destroy]

  def index
    @courses = Course.order('year DESC').page params[:page]
    if @courses.empty? && params[:page]
      not_found
    end
  end

  def new
    @course = Course.new
    render :form, locals: {title: :new_course}
  end

  def edit
    render :form, locals: {title: :edit_course}
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to courses_url, notice: t(:created_course)
    else
      render :form, locals: {title: :new_course}
    end
  end

  def update
    if @course.update(course_params)
      redirect_to courses_url, notice: t(:updated_course)
    else
      render :form, locals: {title: :edit_course}
    end
  end

  def destroy
    @course.destroy
    redirect_to courses_url, notice: t(:destroyed_course)
  end

  private
    def set_course
      @course = Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:year)
    end
end
