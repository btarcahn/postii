class ErrMsgsController < ApplicationController
  wrap_parameters format: [:json]

  def index
    if params[:err_msg].present?
      @err_msg = ErrMsg.find_by(err_code: error_message_params[:err_code])

      if @err_msg.present?
        render json: @err_msg
      else
        render json: CommonHelper.construct_error_message('ERR00003',
                                                          ["err_code #{error_message_params[:err_code]}"])
      end
      return
    end
    @err_msgs = ErrMsg.all
    render json: @err_msgs
  end

  def show
    @err_msg = ErrMsg.find_by(err_code: error_message_params[:err_code])
    if @err_msg.present?
      render json: @err_msg
    else
      render json: CommonHelper.construct_error_message('ERR00005')
    end
  end

  def new
    @err_msg = ErrMsg.new(error_message_params)
    render json: @err_msg
  end

  def create
    @err_msg = ErrMsg.create(
      err_code: error_message_params[:err_code],
      message: error_message_params[:message],
      component: error_message_params[:component],
      additional_note: error_message_params[:additional_note]
    )
    render json: @err_msg
  end

  def update
    @err_msg = ErrMsg.find_by(err_code: error_message_params[:err_code])
    if @err_msg.present?
      @err_msg.update(error_message_params)
    else
      render json: CommonHelper.construct_error_message('ERR00005')
    end
  end

  private
  def error_message_params
    params.require(:err_msg).permit(:err_code, :message,
                                    :component, :additional_note)
  end

end
