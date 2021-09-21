class CreatorsController < ApplicationController
  before_action :require_login

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
    unless @creator
      render json: CommonHelper.construct_error_message(
        'ERR00003', ["Creator with ID #{params[:id]}"]), status: :not_found
      return
    end
    @creator.update(params)
    render json: CommonHelper.construct_error_message('MSG00001')
  end

  def destroy
    @creator = Creator.find(params[:id])
    unless @creator
      render json: CommonHelper.construct_error_message(
        'ERR0003', ["Creator with ID #{params[:id]}"])
      return
    end
    @creator.destroy
    render json: CommonHelper.construct_error_message('MSG00001')
  end

  def index_basic_posters
    @creator = Creator.find(params[:creator_id])
    render json: @creator.basic_posters
  end
end
