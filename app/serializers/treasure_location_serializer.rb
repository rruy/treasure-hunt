class TreasureLocationSerializer
  include JSONAPI::Serializer
  attributes :name, :latitude, :longitude, :active
end
