class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  # after_commit :add_default_avatar, on: %i[create update]


  
  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: "40x40!").processed 
    else
      "default_avatar.jpg"
    end
  end

  # def avatar_thumbnail
  #   if avatar.attached?
  #     avatar.variant(resize: "40x40!").processed 
  #   end
  # end

  # def add_default_avatar 
  #   return if avatar.attached?

  #   avatar.attach(
  #     io: File.open(Rails.root.join('app', 'assets', 'images', 'default_avatar.jpg')),
  #     filename: 'default_avatar.jpg',
  #     content_type: 'image/jpg'
  #   )
  # end
end
