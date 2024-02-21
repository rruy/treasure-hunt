class WinnerSerializer
  include JSONAPI::Serializer
  attributes :user_id, :distance, :create_at
end
