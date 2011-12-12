DEPARTMENTS = ['Executive', 'Sales', 'Development', 'Production', 'Customer Service', 'Accounting', 'HR', 'Marketing']

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
  
  def check_for_admin
    unless current_user.roles.include?(:superuser) || current_user.roles.include?(:admin)
      redirect_to root_path, :notice => "You do not have access."
    end
  end
  
  def check_for_superuser
    unless current_user.roles.include?(:superuser)
      redirect_to root_path, :notice => "You do not have access."
    end
  end
end
