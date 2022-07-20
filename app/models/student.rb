class Student < ApplicationRecord
  belongs_to :school
  validates :name, :birth_date, :gender, :roll_no, :standard,  :email, presence: true

  def self.to_csv(fields = column_names, options = {})
    CSV.generate(options) do |csv|
      csv << fields
      all.each do |student|
        csv << student.attributes.values_at(*fields)
      end
    end
  end
end
