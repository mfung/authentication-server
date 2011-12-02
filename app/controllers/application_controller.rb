class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
  
  def check_for_admin
    unless current_user.roles.include?(:superuser) || current_user.roles.include?(:admin)
      redirect_to root_path, :notice => "You do not have access."
    end
  end
end
