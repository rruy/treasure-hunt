class Api::TreasuresController < Api::ApiController
  before_action :authenticate_user!
  before_action :set_treasure, only: %w[show update destroy]

  def index
    @treasures = Treasure.all
    render json: { users: TreasureSerializer.new(@treasures) }
  end

  def show
    render json: TreasureSerializer.new(@treasure)
  end

  def create
    @treasure = Treasure.new(treasure_params)

    if @treasure.save
      render json: @treasure, status: :created
    else
      render json: @treasure.errors, status: :unprocessable_entity
    end
  end

  def update
    if @treasure.update(treasure_params)
      render json: TreasureSerializer.new(@treasure)
    else
      render json: @treasure.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @treasure.destroy
    head :no_content
  end

  private

  def set_treasure
    @treasure = Treasure.find(params[:id])
  end

  def treasure_params
    params.require(:treasure).permit(:name, :latitude, :longitude, :active)
  end
end
