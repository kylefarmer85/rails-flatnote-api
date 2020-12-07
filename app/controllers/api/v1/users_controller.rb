class Api::V1::UsersController < ApplicationController
  # skip_before_action :authorized, only: [:create]

  def index
    users = User.all 
    render json: users
  end

  def show
      user = User.find(params[:id])
      # break user and comments into two keys
      render json: user
  end 

  def create
    user = User.find_or_create_by(username: params[:username])
    
    if user.save
        render json: { user: {id: user.id, username: user.username}, notes: user.notes}
    else
        # render json: user.errors.full_messages
        render json: {error: "Please try again"}, status: 401
    end
  end

  # def profile
  #   render json: { user: UserSerializer.new(current_user) }, status: :accepted
  # end


  # def create
  #   @user = User.create(user_params)
  #   if @user.valid?
  #     @token = encode_token({ user_id: @user.id })
  #     render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created
  #   else
  #     render json: { error: 'failed to create user' }, status: :not_acceptable
  #   end
  # end

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
      params.require(:user).permit(:username, :email, :password)
  end

end


