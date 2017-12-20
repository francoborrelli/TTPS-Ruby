class StudentsController < ApplicationController
  before_action :set_student, only: %i[edit update destroy]
  before_action :set_course

  def index
    @students = students_ordered.page(params[:page])
    check_pagination(@students)
  end

  def new
    @student = Student.new
    render(:form, locals: { title: :new_student })
  end

  def edit
    render(:form, locals: { title: :edit_student })
  end

  def create
    @student = Student.new(student_params)
    @student.course = @course
    if @student.save
      redirect_to(course_students_path(@course), notice: t(:created_student))
    else
      render(:form, locals: { title: :new_student })
    end
  end

  def update
    if @student.update(student_params)
      redirect_to(course_students_path(@course), notice: t(:updated_student))
    else
      render(:form, locals: { title: :edit_student })
    end
  end

  def destroy
    @student.destroy
    if @student.errors.empty?
      redirect_to(course_students_path(@course), notice: t(:destroyed_student))
    else
      redirect_to(course_students_path(@course), alert: t(:not_destroyed_student))
    end
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def students_ordered
    @course.students.order('surname, name')
  end

  def student_params
    params.require(:student).permit(:surname, :name, :s_number,
                                    :email, :course_id, :dni)
  end
end
