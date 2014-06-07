class Identity < ActiveRecord::Base
  belongs_to :account
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, scope: :provider

  def self.find_for_oauth(auth)
    # TODO test this:
    # where(auth.slice(:provider, :uid)).first_or_create
    where(provider: auth.provider, uid: auth.uid).first_or_create
  end
end
