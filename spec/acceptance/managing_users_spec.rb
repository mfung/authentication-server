require File.dirname(__FILE__) + '/../spec_helper'

feature 'Managing Users', %q{
  As a authorized user [superuser || admin]
  I want to be able to add, edit, and delete users
  So that will be able to allow/not allow users access to our system
} do
  background do
    @superuser = Factory.create(:user)
    @role = Factory.create(:role_superuser)
    @superuser.roles << :superuser
    @superuser.save
    visit new_user_session_path
    fill_in 'Email', :with => @superuser.email
    fill_in 'Password', :with => @superuser.password
    click_button 'Sign in'    
  end
  
  scenario 'should be able to see a listing of users' do
    
  end

  scenario 'should be able to add a user with valid information' do
    
  end
  
  scenario 'should not be able to add a user without an email' do
    
  end
  
  scenario 'should not be able to add a user with an existing email' do
    
  end
  
end