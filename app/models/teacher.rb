class Teacher < ApplicationRecord
  include Validateble
  belongs_to :school

  def self.to_csv(fields = column_names, options = {})
    CSV.generate(options) do |csv|
      csv << fields
      all.each do |teacher|
        csv << teacher.attributes.values_at(*fields)
      end
    end
  end
end
