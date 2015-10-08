class LikesController < ApplicationController
    before_action :logged_in_user
    
    def create
        @user = User.find(params[:micropost_id])
        current_user.like(@user)
    end
end
