class StudentsController < ApplicationController

  before_action :set_student, only: [:edit, :update, :destroy]
  before_action :set_course
  before_action :authenticate_user!

  def index
    @students = @course.students.order("surname, name").page params[:page]
  end

  def new
    @student = Student.new
    render :form, locals: {title: :new_student}
  end

  def edit
    render :form, locals: {title: :edit_student}
  end

  def create
    @student = Student.new(student_params)
    @student.course = @course
    if @student.save
      redirect_to course_students_path(@course), notice: t(:created_student)
    else
      render :form, locals: {title: :new_student}
    end
  end

  def update
    if @student.update(student_params)
      redirect_to course_students_path(@course), notice: t(:updated_student)
    else
      render :form, locals: {title: :edit_student}
    end
  end

  def destroy
    @student.destroy
    redirect_to course_students_path(@course), notice: t(:destroyed_student)
  end

  private
    def set_student
      @student = Student.find(params[:id])
    end

    def set_course
      @course = Course.find(params[:course_id])
    end

    def student_params
      params.require(:student).permit(:surname, :name, :s_number, :email, :course_id, :dni)
    end
end
