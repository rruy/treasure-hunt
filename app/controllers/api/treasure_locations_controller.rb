class Api::TreasureLocationsController < Api::ApiController
  before_action :authenticate_user!
  before_action :set_treasure_location, only: %w[show update destroy]

  def index
    @treasure_locations = TreasureLocation.all
    render json: { users: TreasureLocationSerializer.new(@treasure_locations) }
  end

  def show
    render json: TreasureLocationSerializer.new(@treasure_location)
  end

  def create
    @treasure_location = TreasureLocation.new(treasure_location_params)

    if @treasure_location.save
      render json: @treasure_location, status: :created
    else
      render json: @treasure_location.errors, status: :unprocessable_entity
    end
  end

  def update
    if @treasure_location.update(treasure_location_params)
      render json: TreasureLocationSerializer.new(@treasure_location)
    else
      render json: @treasure_location.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @treasure_location.destroy
    head :no_content
  end

  private

  def set_treasure_location
    @treasure_location = TreasureLocation.find(params[:id])
  end

  def treasure_location_params
    params.require(:treasure_location).permit(:name, :latitude, :longitude, :active)
  end
end
