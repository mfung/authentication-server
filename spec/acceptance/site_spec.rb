require File.dirname(__FILE__) + '/../spec_helper'

feature "Index", %q{
  In order to create an authenticatable account I must be able to get to this site
  As a guest
  I want to land on a welcome page
} do
  
  scenario "I should be able to see a welcome page" do
    visit root_path
    page.should have_content 'Welcome'
  end
end

feature "Authentication", %q{
  In order to manage users 
  As a guest
  I want to get to a get to a login page
} do
  
  scenario "Login screen" do
    visit login_path
    page.should have_content ''
  end
end