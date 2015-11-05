class UsersController < ApplicationController
  
  before_action :logged_in_user, only: [:index, :edit, :show, :update, :destroy]

  def new
  	@user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def create
  	@user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "User has been created successfuly"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
  	@user = User.find(params[:id])
    @entries = current_user.feed.paginate(page: params[:page])
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
  end
  
end
