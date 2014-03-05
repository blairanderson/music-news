class User < ActiveRecord::Base

  has_one :keychain, dependent: :destroy
  has_many :user_song_tags, dependent: :destroy
  has_many :songs, through: :user_song_tags

  validates :uid, numericality: true, uniqueness: true
  validates :name, uniqueness: true

  def self.create_with_omniauth auth
    create! do |user|
      user.keychain = setup_keychain auth
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
    end
  end


private

  def self.setup_keychain auth
    Keychain.build_for_user auth
  end

end
