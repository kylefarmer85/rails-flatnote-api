class Api::V1::UsersController < ApplicationController

  def index
    users = User.all 
    render json: users
  end

  def show
      user = User.find(params[:id])
      render json: user
  end 

  def create
    user = User.find_or_create_by(username: params[:username])
    
    if user.save
        render json: user
    else
        # render json: user.errors.full_messages
        render json: {error: "Please enter a username and email!"}, status: 403
    end
  end

  def update
    user = User.find(params[:id])
  
    user.assign_attributes(user_params)
    
    if user.valid?      
        user.save
        render json: user
    else
        render json: user.errors.full_messages
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy

    render json: user
  end


  private

  def user_params
      params.require(:user).permit(:username)
  end

end


