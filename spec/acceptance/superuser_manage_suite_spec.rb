require File.dirname(__FILE__) + '/../spec_helper'

feature "Management Suite [superuser]", %q{
  In order to manage users and applications
  As a superuser
  I want to be able to Manage Applications and Manage Users
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
  
  scenario "Manage Applications should be on Menu" do
    visit root_path
    page.should have_content "Manage Applications"
  end
  
  scenario "Manage Users should be on Menu" do
    visit root_path
    page.should have_content "Manage Users"
  end

  scenario "View List of Applications" do
    @created_apps = FactoryGirl.create_list(:client, 25)
    visit admin_apps_path
    page.should have_css 'table.applications-list tr', :count => 26
    #save_and_open_page
  end
  
  scenario "View List of Users" do
    @created_apps = FactoryGirl.create_list(:user, 10)
    visit admin_users_path
    page.should have_css '.user_10', :count => 1
    #save_and_open_page
  end
end