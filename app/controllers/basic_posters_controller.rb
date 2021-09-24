class BasicPostersController < ApplicationController
  before_action :set_basic_poster, only: %i[ show update destroy ]

  # GET /basic_posters
  # GET /basic_posters.json
  def index
    @basic_posters = BasicPoster.all
  end

  # GET /basic_posters/1
  # GET /basic_posters/1.json
  def show
  end

  # POST /basic_posters
  # POST /basic_posters.json
  def create
    @basic_poster = BasicPoster.new(basic_poster_params)

    if @basic_poster.save
      render :show, status: :created, location: @basic_poster
    else
      render json: @basic_poster.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /basic_posters/1
  # PATCH/PUT /basic_posters/1.json
  def update
    if @basic_poster.update(basic_poster_params)
      render :show, status: :ok, location: @basic_poster
    else
      render json: @basic_poster.errors, status: :unprocessable_entity
    end
  end

  # DELETE /basic_posters/1
  # DELETE /basic_posters/1.json
  def destroy
    @basic_poster.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_basic_poster
      @basic_poster = BasicPoster.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def basic_poster_params
      params.fetch(:basic_poster, {})
    end
end
