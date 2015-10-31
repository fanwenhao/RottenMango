class Admin::UsersController < ApplicationController

  before_filter :restrict_access
  before_filter :restrict_admin_access

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      UserMailer.welcome_email(@user).deliver
      redirect_to admin_users_path, notice: "#{@user.firstname} was successfully created."
    else
      render :index
    end
  end

  def update
    @user = User.find(params[:id])
    user = @user
    if @user.update_attributes(user_params)
      redirect_to admin_users_path, notice: "#{user.full_name} was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    user = @user
    UserMailer.delete_email(@user).deliver_now
    @user.destroy

    redirect_to admin_users_path, notice: "#{user.full_name} was successfully deleted."
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end

end
