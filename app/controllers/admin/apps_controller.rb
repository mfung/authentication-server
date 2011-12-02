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
  
end
