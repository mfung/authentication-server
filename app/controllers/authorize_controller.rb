class AuthorizeController < ApplicationController
  before_filter :authenticate_user!, :except => [:access_token]
  skip_before_filter :verify_authenticity_token, :only => [:access_token]
  
  def authorize
    AccessGrant.prune!
    client = Client.find_by_app_id(params[:client_id])
    if current_user.access_rights.find_by_client_id(client.id) and current_user.status == 'Active'
      access_grant = current_user.access_grants.create(:client => application)
      redirect_to access_grant.redirect_uri_for(params[:redirect_uri])
    else
      redirect_to root_path, :notice => 'You do not have access to that application.'
    end

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
    client = AccessGrant.find_by_access_token(params['access_token']).client
    role = AccessRight.find_by_user_id_and_client_id(current_user.id, client.id).roles
    data_hash = Digest::MD5.hexdigest(current_user.serialize_data.to_s + "|Role:" + role.to_s + "|Client:" + client.id.to_s)
    
    hash = {
      :provider   => 'exteres',
      :uid        => current_user.id.to_s,
      :user_info  => { :name => current_user.email },
      :extra      => {
        :status => current_user.status,
        :first_name => current_user.first_name,
        :last_name => current_user.last_name,
        :department => current_user.department,
        :role => role,
        :data_hash => data_hash
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