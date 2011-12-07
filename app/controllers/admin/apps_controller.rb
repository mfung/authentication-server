require 'open-uri'

class Admin::AppsController < ApplicationController
  before_filter :authenticate_user!, :check_for_admin
  
  def index
    @apps = Client.all
  end

  def new
    @app = Client.new
  end
  
  def create
    @app = Client.new(params[:client])
    if @app.save
      redirect_to admin_apps_path, :notice => "You successfully added an application."
    else
      #flash[:error] = @app.errors
      render :action => 'new'
    end
  end
  
  def edit
    @app = Client.find(params[:id])
  end
  
  def update
    @app = Client.find(params[:id])
    
    if @app.update_attributes(params[:client])
      redirect_to admin_apps_path, :notice => "Application information has been updated."
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @app = Client.find(params[:id])
    AccessRight.delete_all(['client_id = ?', @app.id])
    AccessGrant.delete_all(['client_id = ?', @app.id])
    @app.destroy
    redirect_to admin_apps_url, :notice => "Successfully removed Application."
  end
  
  def sync_roles
    @app = Client.find_by_id(params[:client][:id])
    if !@app.uri.empty? and !@app.remote_roles_path.empty?
      begin
        remote_uri = open(@app.uri.to_s + @app.remote_roles_path.to_s)
      rescue OpenURI::HTTPError
        redirect_to edit_admin_app_path(:id => @app.id), :notice => "Connection Failure, could not connect to remote client."
      else
        roles = JSON.parse(remote_uri.read)
        hash = Digest::MD5.hexdigest(@app.id.to_s + ":" + roles.sort.join(',').to_s)

        @app.roles = roles.join(',').to_s
        @app.roles_hash = hash

        if @app.save
          redirect_to edit_admin_app_path(:id => @app.id), :notice => "New Roles where added, make sure to update users for this Application."
        else
          redirect_to edit_admin_app_path(:id => @app.id), :notice => "New Roles could not be added."
        end
      end       
    else
      redirect_to edit_admin_app_path(:id => @app.id), :notice => "Can not sync Roles without a URI and Path to Roles API."
    end
  end
  
end
