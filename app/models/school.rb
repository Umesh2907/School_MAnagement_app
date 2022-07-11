class School < ApplicationRecord
    has_many :teachers, dependent: :destroy
    has_many :students, dependent: :destroy
    validates :school_name, presence: true, length: { minimum: 12 }
end
