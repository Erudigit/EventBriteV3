class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :only_see_own_page, only:[:show]

    def index 
        
    end

    def show 
        @user = User.find(params[:id])
        @events = Event.all
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        @user.update(user_params)
        redirect_to user_path(params[:id])
    end

    private

    def user_params
        params.require(:user).permit(:email, :encrypted_password, :description, :first_name, :last_name)
    end

    def only_see_own_page
        @user = User.find(params[:id])
      
        if current_user != @user
          redirect_to root_path, notice: "Sorry, but you are only allowed to view your own profile page."
        end
    end
      

end
