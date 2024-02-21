class Api::ApiController < ApplicationController
  def index
    render json: { message: 'Authenticated successfully!' }
  end
end
