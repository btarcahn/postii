class BasicPostersController < ApplicationController
  def index
    @basic_posters = BasicPoster.all
    render json: @basic_posters
  end

  def show
    @basic_poster = BasicPoster.find(params[:id])
    unless @basic_posters
      render json: CommonHelper.construct_error_message(
        'ERR00003', ["Basic Poster with ID #{params[:id]}"])
      return
    end
    render json: @basic_poster
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
    @basic_poster = BasicPoster.find(params[:id])
    @basic_poster.destroy
    @basic_posters = BasicPoster.all
    render json: @basic_posters
  end
end
