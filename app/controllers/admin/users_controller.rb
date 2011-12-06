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
      #session[:user_id] = @user.id
      redirect_to admin_users_path, :notice => "You successfully created an account."
    else
      render :action => 'new'
    end
  end
  
  def edit
    @user = User.find_by_id(params[:id])
    @apps = Client.all - @user.clients
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
  
  def add_apps
    @user = User.find_by_id(params['clients']['user'])
    
    if params['clients']['id']
      params['clients']['id'].each do |client_id|
        client = Client.find(client_id)
        @user.clients << client unless @user.clients.find_by_id(client.id)
      end
    
      if @user.save
        redirect_to edit_admin_user_path(:id => @user.id)
      end
    else
      redirect_to edit_admin_user_path(:id => @user.id), :notice => 'Please select an Application.'
    end
  end
  
  def remove_app    
    remove_apps_access_grants_and_rights(params[:user_id], params[:id])
    redirect_to edit_admin_user_path(:id => params[:user_id]), :notice => 'Successfully removed Application(s).'
  end
  
  def remove_apps    
    params[:client_ids].each do |client_id|
      remove_apps_access_grants_and_rights(params[:user_id], client_id)
    end
    
    redirect_to edit_admin_user_path(:id => params[:user_id]), :notice => 'Successfully removed Application(s).'
  end
  
  private
  
  def remove_apps_access_grants_and_rights(user_id, client_id)
    AccessGrant.delete_all(["user_id = ? AND client_id = ?", user_id, client_id])
    AccessRight.delete_all(["user_id = ? AND client_id = ?", user_id, client_id])
  end
  
end
