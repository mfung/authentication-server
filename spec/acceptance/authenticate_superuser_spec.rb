require File.dirname(__FILE__) + '/../spec_helper'

feature "Authentication [superuser]", %q{
  In order to manage users and admins
  As a superuser
  I want to be able to login and manage all users and applications in the system
} do
  
  background do
    @superuser = Factory.create(:user)
    @role = Factory.create(:role_superuser)
    @superuser.roles << :superuser
    @superuser.save
  end
  
  scenario "New User Session [Sign In Screen]" do
    visit new_user_session_url
    page.should have_content 'Sign In'
  end

  scenario "Signing In" do
    visit new_user_session_path
    fill_in 'Email', :with => @superuser.email
    fill_in 'Password', :with => @superuser.password
    click_button 'Sign in'
    page.should have_content 'Signed in successfully.'
    page.should have_content @superuser.email
    page.should have_content 'Superuser'
    page.should have_content "Welcome"
  end
end