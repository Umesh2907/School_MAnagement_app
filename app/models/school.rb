class School < ApplicationRecord
  has_many :teachers, dependent: :destroy
  has_many :students, dependent: :destroy
  validates :school_name, presence: true, length: { minimum: 12 }

  def self.to_csv(fields = column_names, options = {})
    CSV.generate(options) do |csv|
      csv << fields
      all.each do |school|
        csv << school.attributes.values_at(*fields)
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      school_hash = row.to_hash
      school = find_or_create_by!(school_name: school_hash['school_name'], description: school_hash['description'], address: school_hash['address'], classes: school_hash['classes'])
      school.update_attributes(school_hash)
    end    
  end
end
