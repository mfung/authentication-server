class MyAccountController < ApplicationController
  def edit
    @user = current_user
  end
  
  def update
    @user = User.find(current_user.id)
    
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
        
    if @user.update_attributes(params[:user])
      redirect_to my_account_index_path, :notice => "Your profile has been updated."
    else
      render :action => 'edit'
    end
  end
end