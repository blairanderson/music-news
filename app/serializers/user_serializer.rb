class UserSerializer < ActiveModel::Serializer
  attributes :id, :provider, :name, :uid, :created_at

  has_one :keychain
end
