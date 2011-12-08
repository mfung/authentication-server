require File.dirname(__FILE__) + '/../spec_helper'

feature 'Managing Users As a Superuser', %q{
  As a authorized user [superuser]
  I want to be able to add, edit, and delete users
  So that will be able to allow/not allow users access to our system
} do
  background do
    @superuser = FactoryGirl.create(:user)
    @role = FactoryGirl.create(:role_superuser)
    @superuser.roles << :superuser
    @superuser.save
    visit new_user_session_path
    fill_in 'Email', :with => @superuser.email
    fill_in 'Password', :with => @superuser.password
    click_button 'Sign in'    
  end
  
  scenario 'should be able to see a listing of all users' do
    
  end

  scenario 'should be able to add a user with valid information' do
    user = FactoryGirl.build(:user)
    visit root_path
    click_link 'Manage Users'
    click_link 'Add User'
    fill_in 'First name', :with => user.first_name
    fill_in 'Last name', :with => user.last_name
    fill_in 'Department', :with => user.department
    fill_in 'Email Address', :with => user.email
    fill_in 'Password', :with => user.password
    fill_in 'Confirm Password', :with => user.password
    click_button 'Add User'
    page.should have_content 'You have successfully added a User.'
    page.should have_css '.user-item', :count => 2
  end
  
  scenario 'should not be able to add a user without an email' do
    user = FactoryGirl.build(:user)
    visit new_admin_user_path
    fill_in 'First name', :with => user.first_name
    fill_in 'Last name', :with => user.last_name
    fill_in 'Department', :with => user.department
    fill_in 'Email Address', :with => ''
    fill_in 'Password', :with => user.password
    fill_in 'Confirm Password', :with => user.password
    click_button 'Add User'
    page.should have_content "Email can't be blank"    
  end
  
  scenario 'should not be able to add a user with an existing email' do
    user = FactoryGirl.create(:user)
    visit new_admin_user_path
    fill_in 'First name', :with => 'New Firt Name'
    fill_in 'Last name', :with => 'New Last Name'
    fill_in 'Department', :with => 'New Department'
    fill_in 'Email Address', :with => user.email
    fill_in 'Password', :with => user.password
    fill_in 'Confirm Password', :with => user.password
    click_button 'Add User'
    page.should have_content "Email has already been taken"    
  end
  
  scenario 'should be able to remove a user' do
    users = FactoryGirl.create_list(:user, 10)
    visit admin_users_path
    page.should have_css '.user-item', :count => 11
    page.find(".user_#{users.last.id}").click_link('Delete')
    page.should have_css '.user-item', :count => 10
  end
  
  scenario 'should be able to deactivate a user' do
    users = FactoryGirl.create_list(:user, 10)
    visit admin_users_path
    
    within "#user_#{users.last.id}_status" do
      select 'Inactive', :from => "user_#{users.last.id}_status_select"
      click_button 'Update Status'
    end
    
    page.should have_content 'Successfully changed User Status'
    page.find_field("user_#{users.last.id}_status_select").value == 'Inactive'
  end
  
  scenario 'should be able to grant a user access to an application' do
    user = FactoryGirl.create(:user)
    app = FactoryGirl.create(:client)
    visit edit_admin_user_path(:id => user.id)
    
    within ".list_all" do
      select app.name, :from => "clients_id"
    end
    click_button 'Add Application(s)'
    page.should have_content "successfully added Application(s)"
    page.should have_css '.user-app-item', :count => 1
    
  end
  
  scenario 'should be able to assign a role to a user on an application' do
    user = FactoryGirl.create(:user)
    apps = FactoryGirl.create_list(:client, 5)
    user.clients << apps[0]
    user.save
    visit edit_admin_user_path(:id => user.id)
    
    within ".list_active" do
      select 'Superadmin', :from => "user_apps_select_#{apps[0].id}"
      click_button 'Update Role'
    end
    page.should have_content 'Successfully changed User Role'
    page.find_field("user_apps_select_#{apps[0].id}").value == "Superadmin"
  end
  
end