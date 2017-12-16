class ScoresController < ApplicationController
  before_action :set_score, only: [:show, :edit, :update, :destroy]
  before_action :set_course, :set_examination, only: [:index]

  # GET /scores
  def index
    @scores = get_scores_ordered.page(params[:page])
  end

  # GET /scores/1
  def show
  end

  # GET /scores/new
  def new
    @score = Score.new
  end

  # GET /scores/1/edit
  def edit
    render(:form, locals: { title: :edit_score })
  end

  # POST /scores
  def create
    @score = Score.new(score_params)

    if @score.save
      redirect_to @course, notice: 'Score was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /scores/1
  def update
    if @score.update(score_params)
      redirect_to @course, notice: 'Score was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /scores/1
  def destroy
    @score.destroy
    redirect_to scores_url, notice: 'Score was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_score
      @score = Score.find(params[:id])
    end

    def set_course
      @course = Course.find(params[:course_id])
    end

    def set_examination
      @examination = Examination.find(params[:examination_id])
    end

    def get_scores_ordered
      @examination.scores.joins(:student).order("name, surname")
    end

    def score_params
      params.require(:score).permit(:score, :examination_id, :student_id)
    end
end
