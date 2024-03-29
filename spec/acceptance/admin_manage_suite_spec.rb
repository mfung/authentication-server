require File.dirname(__FILE__) + '/../spec_helper'

feature "Management Suite [admin]", %q{
  As a admin
  In order to manage users
  So that I can allow users access to applications to do their jobs
} do
  
  background do
    @adminuser = Factory.create(:user)
    @role = Factory.create(:role_admin)
    @adminuser.roles << :admin
    @adminuser.save
    visit new_user_session_path
    fill_in 'Email', :with => @adminuser.email
    fill_in 'Password', :with => @adminuser.password
    click_button 'Sign in'
  end
  
  scenario "Manage Applications should not be on Menu" do
    visit root_path
    page.should_not have_content "Manage Applications"
  end
  
  scenario "Manage Users should be on Menu" do
    visit root_path
    page.should have_content "Manage Users"
  end

  scenario "View List of Applications" do
    @created_apps = FactoryGirl.create_list(:client, 25)
    visit admin_apps_path
    page.should have_content "You do not have access"
  end
end