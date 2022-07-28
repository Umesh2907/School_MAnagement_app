# class StudentJob
#   include Sidekiq::Job

#   def perform(id)
    
#     CrudNotificationMailer.new_creation_mail(id).deliver_now
#   end
# end
