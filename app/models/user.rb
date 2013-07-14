class User < ActiveRecord::Base

  has_one :keychain, dependent: :destroy

  def self.create_with_omniauth auth
    create! do |user|
      user.keychain = setup_keychain auth 
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
    end
  end


private

  def self.setup_keychain auth
    Keychain.build_for_user auth    
  end

end
