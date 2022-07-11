class Teacher < ApplicationRecord
    belongs_to :school
    validates :name, :birth_date, :gender, :email, :subject, presence: true
end
