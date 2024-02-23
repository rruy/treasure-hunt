require 'bigdecimal'

class GameLogicService
  RADIUS_OF_EARTH = 6371e3

  def check_winner(user, guess)
    distance = calculate_distance(guess.latitude, guess.longitude)

    if distance.to_i < 1000 && !user.winner?
      user.update(winner: true, distance: distance)
      guess.update(guessed: true)
      "User #{user.email} is the new winner!"
    elsif user.winner?
      "User #{user.email} has already won!"
    else
      "You didn't win this time, #{user.email}. Try playing again!"
    end
  end

  def calculate_distance(lat1, lon1)
    treasure = Treasure.where(active: true).order(created_at: :asc).first

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
