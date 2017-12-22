class ExaminationsController < ApplicationController
  before_action :set_course
  before_action :set_examination, only: %i[show edit update destroy]

  def index
    @examinations = @course.examinations.page(params[:page])
    check_pagination(@examinations)
  end

  def new
    @examination = @course.examinations.build
    render(:form, locals: { title: :new_examination })
  end

  def edit
    render(:form, locals: { title: :edit_examination })
  end

  def create
    @examination = @course.examinations.build(examination_params)
    if @examination.save
      redirect_to(course_examinations_path(@examination.course),
                  notice: t(:created_examination))
    else
      render(:form, locals: { title: :new_examination })
    end
  end

  def update
    if @examination.update_attributes(examination_params)
      redirect_to(course_examinations_path(@examination.course),
                  notice: t(:updated_examination))
    else
      render(:form, locals: { title: :edit_examination })
    end
  end

  def destroy
    @examination.destroy
    if @examination.errors.empty?
      redirect_to(course_examinations_path(@course),
                  notice: t(:destroyed_examination))
    else
      redirect_to(course_examinations_path(@course),
                  alert: t(:not_destroyed_examination))
    end
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_examination
    @examination = @course.examinations.find(params[:id])
  end

  def examination_params
    params.require(:examination).permit(:title, :date, :min_score)
  end
end
