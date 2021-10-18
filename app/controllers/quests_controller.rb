class QuestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quest, only: %i[ show update destroy ]

  # GET /quests
  # GET /quests.json
  def index
    @quests = Quest.all
  end

  # GET /quests/1
  # GET /quests/1.json
  def show
  end

  # POST /quests
  # POST /quests.json
  def create
    @quest = Quest.new(quest_params)

    if @quest.save
      render :show, status: :created, location: @quest
    else
      render json: @quest.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /quests/1
  # PATCH/PUT /quests/1.json
  def update
    if @quest.update(quest_params)
      render :show, status: :ok, location: @quest
    else
      render json: @quest.errors, status: :unprocessable_entity
    end
  end

  # DELETE /quests/1
  # DELETE /quests/1.json
  def destroy
    @quest.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quest
      @quest = Quest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quest_params
      params.require(:quest).permit(:quest_type, :mandatory, :question, :answer, :basic_poster_id)
    end
end
