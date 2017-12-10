class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course,  only: [:show, :edit, :update, :destroy]

  # GET /courses
  def index
    @courses = Course.order('year DESC').page params[:page]
    if @courses.empty? && params[:page]
      not_found
    end
  end

  # GET /courses/new
  def new
    @course = Course.new
    render :form, locals: {title: "New Course"}
  end

  # GET /courses/1/edit
  def edit
    render :form, locals: {title: "Edit Course"}
  end

  # POST /courses
  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to courses_url, notice: 'Course was successfully created.'
    else
      render :form, locals: {title: "New Course"}
    end
  end

  # PATCH/PUT /courses/1
  def update
    if @course.update(course_params)
      redirect_to courses_url, notice: 'Course was successfully updated.'
    else
      render :form, locals: {title: "Edit Course"}
    end
  end

  # DELETE /courses/1
  def destroy
    @course.destroy
    redirect_to courses_url, notice: 'Course was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def course_params
      params.require(:course).permit(:year)
    end
end
