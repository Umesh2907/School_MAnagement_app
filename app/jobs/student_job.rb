class StudentJob < ApplicationJob
    queue_as :default
  
    def perform(id)
      
      CrudNotificationMailer.new_creation_mail(id).deliver_later
    end
  end