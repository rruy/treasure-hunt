class GuessSerializer
  include JSONAPI::Serializer
  attributes :user_id, :latitude, :longitude
end
