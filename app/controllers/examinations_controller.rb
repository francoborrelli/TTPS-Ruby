class ExaminationsController < ApplicationController
  before_action :set_examinations
  before_action :set_examination, only: [:show, :edit, :update, :destroy]

  # GET courses/1/examinations
  def index
    @examinations = @course.examinations
  end

  # GET courses/1/examinations/1
  def show
  end

  # GET courses/1/examinations/new
  def new
    @examination = @course.examinations.build
  end

  # GET courses/1/examinations/1/edit
  def edit
  end

  # POST courses/1/examinations
  def create
    @examination = @course.examinations.build(examination_params)

    if @examination.save
      redirect_to([@examination.course, @examination], notice: 'Examination was successfully created.')
    else
      render action: 'new'
    end
  end

  # PUT courses/1/examinations/1
  def update
    if @examination.update_attributes(examination_params)
      redirect_to([@examination.course, @examination], notice: 'Examination was successfully updated.')
    else
      render action: 'edit'
    end
  end

  # DELETE courses/1/examinations/1
  def destroy
    @examination.destroy

    redirect_to course_examinations_url(@course)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_examinations
      @course = Course.find(params[:course_id])
    end

    def set_examination
      @examination = @course.examinations.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def examination_params
      params.require(:examination).permit(:title, :date, :min_mark)
    end
end
