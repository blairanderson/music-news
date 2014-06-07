class Account < ActiveRecord::Base

  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  has_many :identities, dependent: :destroy
  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and
  devise  :database_authenticatable,
          :omniauthable,
          :recoverable,
          :registerable,
          :rememberable,
          :trackable,
          :validatable,
          # :omniauth_providers => [:twitter, :github, :soundcloud]
          :omniauth_providers => [:twitter, :github]

  def self.find_for_oauth(auth, signed_in_resource = nil)
    identity = Identity.find_for_oauth(auth)

    account = signed_in_resource ? signed_in_resource : identity.account

    # Create the account if needed
    if account.nil?
      binding.pry
      email = auth.info.email
      account = Account.where(email: email).first if email

      # Create the account if it's a new registration
      if account.nil?
        account = Account.new(
          email: email || "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        account.save!
      end
    end

    # Associate the identity with the account if needed
    if identity.account != account
      identity.account = account
      identity.save!
    end
    account
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end


end
