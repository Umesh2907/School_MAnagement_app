class User < ApplicationRecord
  has_one_attached :avatar
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, 
         :rememberable, :validatable, :trackable, :confirmable,
         :omniauthable, omniauth_providers: [:github, :google_oauth2]
         
  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
  end
  

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.github"] && session["devise.github_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
      if data = session["devise.google_oauth2"] && session["devise.google_oauth2_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end    
  end

  def self.to_csv(fields = column_names, options = {})
    CSV.generate(options) do |csv|
      csv << fields
      all.each do |user|
        csv << user.attributes.values_at(*fields)
      end
    end
  end
  
  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: "40x40!").processed 
    else
      "default_avatar.jpg"
    end
  end
end
