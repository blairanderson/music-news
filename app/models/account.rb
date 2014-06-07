class Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and
  devise  :database_authenticatable,
          :registerable,
          :recoverable,
          :rememberable,
          :trackable,
          :validatable,
          :omniauthable,
          # :omniauth_providers => [:twitter, :github, :soundcloud]
          :omniauth_providers => [:twitter]
end
