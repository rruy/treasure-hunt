class GameLogicService
  RADIUS_OF_EARTH = 6371e3
  TREASURE_LATITUDE = -27.4421
  TREASURE_LONGITUDE = -48.5062

  def check_winner(user, lat, lon)
    distance = calculate_distance(lat, lon)

    if distance.to_i < 1000 && !user.winner?
      user.update(winner: true)
      send_email
      "User #{user.email} is the new winner!"
    elsif user.winner?
      "User #{user.email} has already won!"
    else
      "Sorry, #{user.email}, you is not winner yet. Try one more time!"
    end
  end

  def calculate_distance(lat1, lon1)
    # Convert latitude and longitude from degrees to radians
    lat1_rad = lat1.to_radians
    lon1_rad = lon1.to_radians
    lat2_rad = TREASURE_LATITUDE.to_radians
    lon2_rad = TREASURE_LONGITUDE.to_radians

    # Haversine formula
    dlon = lon2_rad - lon1_rad
    dlat = lat2_rad - lat1_rad
    a = Math.sin(dlat/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon/2)**2
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

    RADIUS_OF_EARTH * c
  end

  def send_email
    begin
      UserMailer.with(user: current_user).winner_confirmation_email.deliver_now
    rescue => e
      # logger.info "Error when processing User mailer #{current_user.email}"
    end
  end
end
