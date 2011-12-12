require File.dirname(__FILE__) + '/../spec_helper'

feature "Authentication [admin]", %q{
  As an admin
  I want to be able to login and manage users only
  So that I don't cause a security risk I only have access to users
} do
  
  background do
    @adminuser = Factory.create(:user)
    @role = Factory.create(:role_admin)
    @adminuser.roles << :admin
    @adminuser.save
  end
  
  scenario "should be able to see a sign in form [Sign In Screen]" do
    visit new_user_session_url
    page.should have_content 'Sign In'
  end

  scenario "should be able to sign in" do
    visit new_user_session_path
    fill_in 'Email', :with => @adminuser.email
    fill_in 'Password', :with => @adminuser.password
    click_button 'Sign in'
    page.should have_content 'Signed in successfully.'
    page.should have_content @adminuser.email
    page.should have_content 'Admin'
    page.should have_content "Welcome"
  end
  
  scenario 'should be only able to see a list of users' do
    
  end
end