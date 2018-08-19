class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:id])

    if current_user.follows? @user      
      redirect_to user_path(@user), alert: 'Usuário já está sendo seguido!'
    else
      current_user.follow! @user
      redirect_to user_path(@user), notice: 'Usuário seguido com sucesso!'
    end
  end

  def destroy
    pry
    @user = User.find(params[:id])
    current_user.unfollow! @user
    redirect_to user_path(@user), notice: 'Usuário deixou de ser seguido com sucesso!'
  end
end