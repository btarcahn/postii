class CreatorsController < ApplicationController
  before_action :set_creator, only: %i[ show update destroy index_basic_posters ]

  # GET /creators
  # GET /creators.json
  def index
    @creators = Creator.all
  end

  # GET /creators/1
  # GET /creators/1.json
  def show
  end

  # POST /creators
  # POST /creators.json
  def create
    @creator = Creator.new(creator_params)

    if @creator.save
      render :show, status: :created, location: @creator
    else
      render json: @creator.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /creators/1
  # PATCH/PUT /creators/1.json
  def update
    if @creator.update(creator_params)
      render :show, status: :ok, location: @creator
    else
      render json: @creator.errors, status: :unprocessable_entity
    end
  end

  # DELETE /creators/1
  # DELETE /creators/1.json
  def destroy
    @creator.destroy
  end

  def index_basic_posters
    render json: @creator.basic_posters
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_creator
      @creator = Creator.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def creator_params
      params.require(:creator).permit(
      :creator_name, :email_address, :sector_code, :prefix_code
      )
    end
end
