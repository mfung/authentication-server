require File.dirname(__FILE__) + '/../spec_helper'

feature "Management Suite [user]", %q{
  As a user
  I should only have access to edit my account
  So that I do not cause a security risk and try to do things I shouldn't
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
  
  scenario "Manage Applications should not be on Menu" do
    visit root_path
    page.should_not have_content "Manage Applications"
  end
  
  scenario "Manage Users should not be on Menu" do
    visit root_path
    page.should_not have_content "Manage Users"
  end

  scenario "View List of Applications" do
    @created_apps = FactoryGirl.create_list(:client, 25)
    visit admin_apps_path
    page.should have_content "You do not have access"
  end
  
  scenario "View List of Users" do
    @created_apps = FactoryGirl.create_list(:user, 10)
    visit admin_users_path
    page.should have_content "You do not have access"
  end
end