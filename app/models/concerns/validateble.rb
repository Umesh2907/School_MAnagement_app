module Validateble
 extend ActiveSupport::Concern
 
 included do
    validates :name, :birth_date, :gender, :email, :subject, presence: true
 end
end