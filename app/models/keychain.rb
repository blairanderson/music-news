class Keychain < ActiveRecord::Base

  belongs_to :user

  def self.build_for_user auth
    create do |key|
      key.api_token               = build_api_token
      key.api_secret              = build_api_secret
      key.auth_credentials_secret = auth.credentials.secret
      key.auth_credentials_token  = auth.credentials.token
    end
  end

private
  
  def self.build_api_token
    generate_base64_string 12
  end

  def self.build_api_secret
    generate_base64_string 48    
  end

  def self.generate_base64_string base
    SecureRandom.urlsafe_base64 base
  end

end
