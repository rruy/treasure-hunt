class Api::ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: { message: 'Authenticated successfully!' }
  end

  def page_param
    params[:page].nil? ? 1 : params[:page]
  end
end
