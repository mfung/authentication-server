require File.dirname(__FILE__) + '/../spec_helper'

feature "Edit my Account", %q{
  In order to keep my account current
  As a Account Holder
  I want to be able to update my information
} do
  
  background do
    @user = Factory.create(:user)
    @role = Factory.create(:role_user)
    @user.roles << :user
    @user.save
    
    visit new_user_session_path
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => @user.password
    click_button 'Sign in'
  
  end
  
  scenario "Update user information" do
    visit edit_my_account_path(:id => @user.id)
    fill_in 'First name', :with => 'Mikey'
    fill_in 'Last name', :with => 'Likesit'
    fill_in 'Department', :with => 'My Department'
    fill_in 'Email Address', :with => 'new@email.com'
    
    click_button 'Update'

    page.should have_content 'Your profile has been updated.'
  end

  scenario "Update user password" do
    visit edit_my_account_path(:id => @user.id)

    fill_in 'Password', :with => 'Password1'
    fill_in 'Confirm Password', :with => 'Password1'
    
    click_button 'Update'
    
    page.should have_content 'Your profile has been updated.'
  end
  
  scenario "Update user password with invalid confirmation" do
    visit edit_my_account_path(:id => @user.id)

    fill_in 'Password', :with => 'Password1'
    fill_in 'Confirm Password', :with => 'Password2'
    
    click_button 'Update'
    
    page.should have_content 'Invalid Fields'
  end

end