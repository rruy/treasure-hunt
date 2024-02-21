class GameLogicService
  RADIUS_OF_EARTH = 6371e3
  TREASURE_LATITUDE = -27.4421
  TREASURE_LONGITUDE = -48.5062

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

  # Monkey-patch Float class to add a method to convert degrees to radians
  class Float
    def to_radians
      self * Math::PI / 180
    end
  end
end
