class BasicPostersController < ApplicationController
  before_action :require_login
  before_action :set_basic_poster, only: [:show, :update, :destroy, :index_quests]

  def index
    @basic_posters = BasicPoster.all
    render json: @basic_posters
  end

  def show
    unless @basic_poster
      render json: CommonHelper.construct_error_message(
        'ERR00003', ["Basic Poster with ID #{params[:id]}"])
      return
    end
    render json: @basic_poster
  end

  def update
    if @basic_poster.update(basic_poster_params)
      render json: @basic_poster, status: :ok
    else
      render json: CommonHelper.construct_error_message('ERR00003', ["Poster with id: #{params[:id]}"])
    end
  end

  def create
    @creator = Creator.find(params[:creator_id])
    unless @creator
      render json: CommonHelper.construct_error_message(
        'ERR00003', ["Creator with ID #{params[:creator_id]}"]), status: :not_found
      return
    end
    @basic_poster = @creator.basic_posters.create(
      title: params[:title],
      description: params[:description],
      security_question: params[:security_question],
      security_answer: params[:security_answer],
      passcode: params[:passcode]
    )
    render json: @basic_poster
  end

  def destroy
    @basic_poster.destroy
    render json: CommonHelper.construct_error_message('MSG00001')
  end

  def index_quests
    render json: @basic_poster.quests
  end

  private
  def set_basic_poster
    @basic_poster = BasicPoster.find(params[:id])
  end

  def basic_poster_params
    params.require(:basic_poster).permit(
      :title, :description, :security_question, :security_answer, :creator_id)
  end
end
