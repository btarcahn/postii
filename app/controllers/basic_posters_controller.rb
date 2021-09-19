class BasicPostersController < ApplicationController
  def index
    @basic_posters = BasicPoster.all
    render json: @basic_posters
  end

  def show
    @basic_poster = BasicPoster.find(params[:id])
    render json: @basic_poster
  end

  def create
    @creator = Creator.find(params[:creator_id])
    render json: {
      response_code: 404,
      response_body: "#{params[:creator_id]} does not exist."
    }, status: :not_found and return unless @creator
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
