class UserSerializer
  include JSONAPI::Serializer
  attributes :email, :winner
end
