class LikesController < ApplicationController
    before_action :logged_in_user
    
    def create
        # @user = User.find(params[:micropost_id])
        @micropost = Micropost.find(params[:micropost_id])
        current_user.like(@micropost)
        
    end
end
