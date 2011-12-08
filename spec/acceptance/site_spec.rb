require File.dirname(__FILE__) + '/../spec_helper'

feature "Index", %q{
  As a guest [user not logged in yet]
  I want to land on a welcome page
  So that I can have access to a Sign In
} do
  
  scenario "I should be able to see a welcome page" do
    visit root_path
    page.should have_content 'Welcome'
  end
  
  scenario "I should be able to see a sign in link" do
    visit root_path
    page.should have_content 'Sign In'
  end
end