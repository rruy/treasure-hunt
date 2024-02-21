class Api::ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: { message: 'Authenticated successfully!' }
  end
end
