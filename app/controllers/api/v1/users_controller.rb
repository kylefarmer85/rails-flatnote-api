# require 'jwt'
class Api::V1::UsersController < ApplicationController

  def create
    
    user = User.create(username: params[:username], password: params[:password])
    
    if user.save
      
      payload = { user_id: user.id }

      token = JWT.encode(payload, 'my_secret', 'HS256')

        render json: { user: {id: user.id, username: user.username}, notes: user.notes, token: token}
    else
        # render json: user.errors.full_messages
        render json: {error: user.errors.full_messages}, status: 401
    end
  end


  # def update
  #   user = User.find(params[:id])
  
  #   user.assign_attributes(user_params)
    
  #   if user.valid?      
  #       user.save
  #       render json: user
  #   else
  #       render json: user.errors.full_messages
  #   end
  # end

  def destroy
    user = User.find(params[:id])
    user.destroy

    render json: user
  end


  # private

  # def user_params
  #     params.require(:user).permit(:username, :password)
  # end

end


