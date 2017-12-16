class ExaminationsController < ApplicationController
  before_action :set_course
  before_action :set_examination, only: %i[show edit update destroy ]

  # GET courses/1/examinations
  def index
    @examinations = @course.examinations.order('date').page(params[:page])
  end

  # GET courses/1/examinations/new
  def new
    @examination = @course.examinations.build
    render(:form, locals: { title: :new_examination })
  end

  # GET courses/1/examinations/1/edit
  def edit
    render(:form, locals: { title: :edit_examination })
  end

  # POST courses/1/examinations
  def create
    @examination = @course.examinations.build(examination_params)

    if @examination.save
      redirect_to(course_examinations_path(@examination.course),
                  notice: t(:created_examination))
    else
      render(:form, locals: { title: :new_examination })
    end
  end

  # PUT courses/1/examinations/1
  def update
    if @examination.update_attributes(examination_params)
      redirect_to(course_examinations_path(@examination.course),
                  notice: t(:updated_examination))
    else
      render(:form, locals: { title: :edit_examination })
    end
  end

  # DELETE courses/1/examinations/1
  def destroy
    @examination.destroy
    redirect_to(course_examinations_path(@course),
                notice: t(:destroyed_examination))
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_examination
    @examination = @course.examinations.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def examination_params
    params.require(:examination).permit(:title, :date, :min_score)
  end
end
