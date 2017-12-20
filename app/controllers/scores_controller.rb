class ScoresController < ApplicationController
  before_action :set_examination, only: %i[index update]

  before_action :build_scores, only: [:index]

  def index; end

  def update
    @examination.assign_attributes(score_params)
    if @examination.save
      delete_scores
      redirect_to course_examination_scores_path(@examination.course, @examination),
                  notice: (t :updated_scores)
    else
      build_scores
      render :index
    end
  end

  private

  def set_examination
    @examination = Examination.find(params[:examination_id])
  end

  def build_scores
    @examination.students.each do |student|
      @examination.scores.build(student: student) unless student.took_exam?(@examination)
    end
  end

  def score_params
    params.require(:examination).permit(scores_attributes: %i[score id student_id])
  end

  def delete_scores
    score_params.fetch(:scores_attributes).each do |_key, score|
      Score.find(score['id']).destroy if score['id'] && score['score'].empty?
    end
  end
end
