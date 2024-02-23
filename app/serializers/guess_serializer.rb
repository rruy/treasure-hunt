class GuessSerializer
  include JSONAPI::Serializer
  attributes :id, :user_id, :latitude, :longitude
end
