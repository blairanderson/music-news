class KeychainSerializer < ActiveModel::Serializer
  attributes :api_token, :api_secret
end
