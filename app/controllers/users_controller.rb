class UsersController < ApplicationController
   def index
      @users = User.all

      respond_to do |format|
        format.html
        format.csv { send_data @users.to_csv(['email']) }
      end
   end

   def import
      User.import(params[:file])
      redirect_to root_url, notice: "User imported."
   end
end
