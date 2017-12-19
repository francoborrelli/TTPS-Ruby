class ScoresController < ApplicationController
  before_action :set_examination, only: %i[index update]

  def index
    @scores = @examination.scores
  end

  def update
    if @examination.update(score_params)
      redirect_to course_examination_scores_path(@examination.course, @examination),
                  notice: (t :updated_scores)
    else
      render :index
    end
  end

  private

  def set_examination
    @examination = Examination.find(params[:examination_id])
  end

  def score_params
    params.require(:examination).permit(scores_attributes: %i[score id student_id _destroy])
  end
end
