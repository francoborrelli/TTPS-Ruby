class ScoresController < ApplicationController
  before_action :set_course, :set_examination, only: %i[index update]

  # GET /scores
  def index
    @scores = get_scores_ordered.page(params[:page])
  end

  # PATCH/PUT /scores/1
  def update
    if @examination.update(score_params)
      redirect_to course_examination_scores_path(@course, @examination), notice: (t :updated_scores)
    else
      render :index
    end
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_examination
    @examination = Examination.find(params[:examination_id])
  end

  def get_scores_ordered
    @examination.scores.where.not('score' => nil).joins(:student).order('name, surname')
  end

  def score_params
    params.require(:examination).permit(scores_attributes: %i[score id student_id _destroy])
  end
end
