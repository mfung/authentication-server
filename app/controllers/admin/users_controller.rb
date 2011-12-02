class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!, :check_for_admin

  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to admin_users_path, :notice => "You successfully created an account."
    else
      render :action => 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
    
    if @user.update_attributes(params[:user])
      redirect_to admin_users_path, :notice => "Your profile has been updated."
    else
      render :action => 'edit'
    end
  end
  
end
