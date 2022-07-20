class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable, :confirmable


  has_one_attached :avatar

  def self.to_csv(fields = column_names, options = {})
    CSV.generate(options) do |csv|
      csv << fields
      all.each do |user|
        csv << user.attributes.values_at(*fields)
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      user_hash = row.to_hash
      user = find_or_create_by!(email: user_hash['email'])
      user.update_attributes(user_hash)
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
