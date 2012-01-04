class Admin::UserAppsController < ApplicationController
  def create
    @user = User.find_by_id(params['clients']['user'])
    
    if params['clients']['id']
      params['clients']['id'].each do |client_id|
        @client = Client.find(client_id)
        @user.clients << @client unless @user.clients.find_by_id(@client.id)
      end
    
      if @user.save
        status = :ok
        notice = 'You have successfully added Application(s)'
      end
    else
      status = :error
      notice = 'Please select an Application.'
    end
    @apps = Client.all - @user.clients
    respond_to do |format|
      format.html {redirect_to edit_admin_user_path(:id => @user.id), :notice => notice}
      format.js do 
        str = render_to_string :partial => 'applications', :locals => {:user => @user, :clients => @user.clients}
        render :json => str.to_json
      end
    end
  end

  def destory
    remove_apps_access_grants_and_rights(params[:user_id], params[:id])
    @user = User.find_by_id(params[:user_id])  
    @apps = Client.all - @user.clients
    respond_to do |format|
      format.html {redirect_to edit_admin_user_path(:id => params[:user_id]), :notice => 'Successfully removed Application(s).'}
      format.js do
        str = render_to_string :partial => 'applications', :locals => {:user => @user, :clients => @user.clients}
        render :json => str.to_json
      end
    end
  end

  def role
    @user = User.find_by_id(params[:user_id])
    ar = @user.access_rights.find_by_client_id(params[:client_id])
    ar.roles = params[:user][:roles]
    ar.save
    respond_to do |format|
      format.html {redirect_to edit_admin_user_path(:id => params[:user_id]), :notice => 'Successfully changed User Role.'}
      format.js {head :ok}
    end
  end

  def status
    @user = User.find_by_id(params[:user_id])
    @user.status = params[:user][:status]
    @user.save
    AccessGrant.delete_all(["user_id = ?", @user.id]) if @user.status == 'Inactive'
    respond_to do |format|
      format.html {redirect_to admin_users_path, :notice => 'Successfully changed User Status.'}
      format.js {head :ok}
    end
  end
  
  def default_user
    @user = User.find_by_id(params[:user_id])
    access_right = @user.access_rights.find_by_client_id(params[:application_id])
    
    if params[:user][:default] == 'True'
      set_default_user_false(access_right.client_id)
      access_right.default_user = true
    else
      access_right.default_user = false
    end
    access_right.save
    
    respond_to do |format|
      format.json {render :json => @user, :status => :ok}
    end
  end

  private
  
  def destory_access_grants_and_rights(user_id, client_id)
    AccessGrant.delete_all(["user_id = ? AND client_id = ?", user_id, client_id])
    AccessRight.delete_all(["user_id = ? AND client_id = ?", user_id, client_id])
  end
  
  def set_default_user_false(client_id) 
    ActiveRecord::Base.connection.execute("UPDATE access_rights SET default_user='f' WHERE client_id=#{client_id}")
  end
end
