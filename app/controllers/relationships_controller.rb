class RelationshipsController < ApplicationController
  def create
    other_user = User.find(params[:id])
    current_user.follow! other_user
    redirect_to user_path(current_user)
  end

  def destroy
    other_user = User.find(params[:id])
    current_user.unfollow! other_user
    redirect_to user_path(current_user)
  end
end