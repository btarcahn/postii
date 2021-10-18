class BasicPostersController < ApplicationController
  before_action :set_basic_poster, only: %i[ show update destroy index_quests create_quest ]

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

  def index_quests
    render json: @basic_poster.quests
  end

  def create_quest
    quest = @basic_poster.quests.create(
      quest_type: quest_params[:quest_type], mandatory: quest_params[:mandatory],
      question: quest_params[:question], answer: quest_params[:answer])

    if quest
      render quest, status: :ok, location: quest
    else
      render json: quest.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_basic_poster
      @basic_poster = BasicPoster.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def basic_poster_params
      params.require(:basic_poster)
            .permit(:creator_id, :poster_id, :title,
                    :description, :security_question, :security_answer,
                    :passcode)
    end

    def quest_params
      params.require(:quest).permit(:quest_type, :mandatory, :question, :answer)
    end
end
