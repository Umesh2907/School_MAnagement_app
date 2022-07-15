class UsersController < ApplicationController
   def index
    @schools = School.all
   end
end
