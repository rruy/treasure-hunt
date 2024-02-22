require 'bigdecimal'

class GameLogicService
  RADIUS_OF_EARTH = 6371e3

  def check_winner(user, lat, lon)
    distance = calculate_distance(lat, lon)

    if distance.to_i < 1000 && !user.winner?
      user.update(winner: true, distance: distance)
      "User #{user.email} is the new winner!"
    elsif user.winner?
      "User #{user.email} has already won!"
    else
      "Sorry, #{user.email}, you is not winner yet. Try one more time!"
    end
  end

  def calculate_distance(lat1, lon1)
    treasure = TreasureLocation.where(active: true).order(created_at: :asc).first

    lat1_rad = degrees_to_radians(lat1)
    lon1_rad = degrees_to_radians(lon1)

    lat2_rad = degrees_to_radians(treasure.latitude)
    lon2_rad = degrees_to_radians(treasure.longitude)

    # Haversine formula
    dlon = lon2_rad - lon1_rad
    dlat = lat2_rad - lat1_rad
    a = Math.sin(dlat/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon/2)**2
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

    (RADIUS_OF_EARTH * c).to_i
  end

  def degrees_to_radians(degrees)
    degrees * Math::PI / 180.0
  end
end
