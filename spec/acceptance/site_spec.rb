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