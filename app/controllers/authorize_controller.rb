class AuthorizeController < ApplicationController
  before_filter :authenticate_user!, :except => [:access_token]
  skip_before_filter :verify_authenticity_token, :only => [:access_token]
  
  def authorize
    AccessGrant.prune!
    
    # need to add code here to check to see if user has rights for application
    
    access_grant = current_user.access_grants.create(:client => application)
    redirect_to access_grant.redirect_uri_for(params[:redirect_uri])
  end
  
  def access_token
    application = Client.authenticate(params[:client_id], params[:client_secret])
    
    if application.nil?
      render :json => {:error => 'Application is not in the system or you are not allowed access!'}
      return
    end
    
    access_grant = AccessGrant.authenticate(params[:code], application.id)
    
    if access_grant.nil?
      render :json => {:error => 'Could not authenticate access code'}
      return
    end
    
    access_grant.start_expiry_period!
    render :json => {:access_token => access_grant.access_token, :refresh_token => access_grant.refresh_token, :expires_in => Devise.timeout_in.to_i}
  end
  
  def failure
    render :text => "ERROR: #{params[:message]}"
  end
  
  def user
    hash = {
      :provider   => 'exteres',
      :uid        => current_user.id.to_s,
      :user_info  => { :name => current_user.email },
      :extra      => {
        :admin => current_user.admin?,
        :first_name => current_user.first_name,
        :last_name => current_user.last_name,
        :department => current_user.department,
        :roles => current_user.roles
      }
    }
    render :json => hash.to_json
  end
  
  def isalive
    warden.set_user(current_user, :scope => :user)
    response = {'status' => 'ok'}
    
    respond_to do |format|
      format.any { render :json => response.to_json }
    end
  end
  
  protected
  
  def application
    @application ||= Client.find_by_app_id(params[:client_id])
  end

end