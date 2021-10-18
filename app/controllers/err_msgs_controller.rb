class ErrMsgsController < ApplicationController
  before_action :set_err_msg, only: %i[ show update destroy ]

  # GET /err_msgs
  # GET /err_msgs.json
  def index
    @err_msgs = ErrMsg.all
  end

  # GET /err_msgs/1
  # GET /err_msgs/1.json
  def show
  end

  # POST /err_msgs
  # POST /err_msgs.json
  def create
    @err_msg = ErrMsg.new(err_msg_params)

    if @err_msg.save
      render :show, status: :created, location: @err_msg
    else
      render json: @err_msg.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /err_msgs/1
  # PATCH/PUT /err_msgs/1.json
  def update
    if @err_msg.update(err_msg_params)
      render :show, status: :ok, location: @err_msg
    else
      render json: @err_msg.errors, status: :unprocessable_entity
    end
  end

  # DELETE /err_msgs/1
  # DELETE /err_msgs/1.json
  def destroy
    @err_msg.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_err_msg
      @err_msg = ErrMsg.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def err_msg_params
      params.require(:err_msg).permit(
        :err_code, :message, :reason, :component, :additional_note)
    end
end
