class CreatorsController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods

  TOKEN = "secret"

  before_action :authenticate

  def index
    @creators = Creator.all
    render json: @creators
  end

  def show
    @creator = Creator.find(params[:id])
    render json: @creator
  end

  def create
    @creator = Creator.create(
      creator_name: params[:creator_name],
      email_address: params[:email_address],
      sector_code: params[:sector_code],
      prefix_code: params[:prefix_code],
    )
    render json: @creator
  end

  def update
    @creator = Creator.find(params[:id])
    @creator.update(params)
  end

  def destroy
    @creator = Creator.find(params[:id])
    unless @creator
      render json: {
        deleted: false,
        content: "Creator not found!"
      }, status: :not_found
    end
    @creator.destroy
    render json: {
      deleted: true,
      content: @creator
    }
  end

  def index_basic_posters
    @creator = Creator.find(params[:creator_id])
    render json: @creator.basic_posters
  end

  private
  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      ActiveSupport::SecurityUtils.secure_compare(token, TOKEN)
    end
  end
end
