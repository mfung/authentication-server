require File.dirname(__FILE__) + '/../spec_helper'

feature 'Managing Applications', %q{
  As a authorized user [superuser || admin]
  In want to be able to add, remove, edit applications
  So that I can let more internal applications use a single sign on service
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
  
  scenario 'should list all applications in the system' do
    clients = FactoryGirl.create_list(:client, 5)
    visit admin_apps_path
    page.should have_css '.app-item', :count => 5
  end
  
  scenario 'should be able to add a new application' do
    visit admin_apps_path
    click_link 'Add Application'
    fill_in 'Name', :with => 'New Application'
    fill_in 'Uri', :with => 'http://example.com'
    fill_in 'Remote roles path', :with => '/api/roles'
    click_button 'Add Application'
    page.should have_content 'You successfully added an application.'
    page.should have_css '.app-item', :count => 1
  end
  
  scenario 'should not be able to add an application with out a Name' do
    visit new_admin_app_path
    fill_in 'Name', :with => ''
    fill_in 'Uri', :with => 'http://example.com'
    fill_in 'Remote roles path', :with => '/api/roles'
    click_button 'Add Application'
    page.should have_content 'Invalid'
    page.should have_content "Name can't be blank"
  end
  
  scenario 'should not be able to add an application with an existing name' do
    client = FactoryGirl.create(:client)
    visit new_admin_app_path
    fill_in 'Name', :with => client.name
    click_button 'Add Application'
    page.should have_content 'Invalid'
    page.should have_content 'Name has already been taken'
  end
  
  scenario 'should not be able to add an application with an existing uri' do
    client = FactoryGirl.create(:client)
    visit new_admin_app_path
    fill_in 'Name', :with => 'Test Application 2'
    fill_in 'Uri', :with => client.uri
    click_button 'Add Application'
    page.should have_content 'Invalid'
    page.should have_content 'Uri has already been taken'
  end
  
  scenario 'should be able to remove an application' do
    clients = FactoryGirl.create_list(:client, 5) 
    visit admin_apps_path
    click_link 'Delete'
    page.should have_css '.app-item', :count => 4
  end
  
  scenario 'should be able to edit an applications information' do
    client = FactoryGirl.create(:client)
    visit admin_apps_path
    click_link client.name
    page.should have_content "Edit Application: #{client.name}"
    fill_in 'Name', :with => 'Updated Application'
    fill_in 'Uri', :with => 'http://updated.com'
    fill_in 'Remote roles path', :with => '/updated/roles'
    click_button 'Update'
    page.should have_content 'Application information has been updated.'
    page.should have_content 'Updated Application'    
  end
end