class StudentsController < ApplicationController

  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :set_course
  before_action :authenticate_user!

  def index
    @students = @course.students.order("surname DESC, name DESC").page params[:page]
  end

  def show
  end

  def new
    @student = Student.new
    render :form, locals: {title: (t(:new) +' ' + t(:student))}
  end

  def edit
    render :form, locals: {title: (t(:edit) +' ' + t(:student))}
  end

  def create
    @student = Student.new(student_params)
    @student.course = @course
    if @student.save
      redirect_to course_students_path(@course, @student), notice: 'Student was successfully created.'
    else
      render :form, locals: {title: (t(:edit) +' ' + t(:student))}
    end
  end

  def update
    if @student.update(student_params)
      redirect_to course_student_path(@course, @student), notice: 'Student was successfully updated.'
    else
      render :form, locals: {title: (t(:new) +' ' + t(:student))}
    end
  end

  def destroy
    @student.destroy
    redirect_to course_students_path(@course), notice: 'Student was successfully destroyed.'
  end

  private
    def set_student
      @student = Student.find(params[:id])
    end

    def set_course
      @course = Course.find(params[:course_id])
    end

    def student_params
      params.require(:student).permit(:surname, :name, :s_number, :email, :course_id)
    end
end
