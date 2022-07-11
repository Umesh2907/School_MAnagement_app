class Student < ApplicationRecord
    belongs_to :school
    validates :name, :birth_date, :gender, :roll_no, :standard,  :email, presence: true
end
