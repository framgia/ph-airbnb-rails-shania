class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
         
  # Signup with Facebook
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      if user.email?
        return user
      else
        user.email = auth.info.email
        user.provider = auth.provider
        user.name = auth.info.name
        user.uid = auth.uid
        user.password = Devise.friendly_token[0,20]
        user.image = auth.info.image
        user.skip_confirmation! #skips email confirmation
      end
    end
  end

end
