require 'spec_helper'

describe Admin::UsersController do
  include Devise::TestHelpers
  
  before (:each) do
      @user = FactoryGirl.create(:user)
      @role = FactoryGirl.create(:role_superuser)
      @user.roles << :superuser
      @user.save
      sign_in @user
  end
  
  describe "GET 'index" do
    it "should be successfull" do
      get 'index'
      response.should be_success
    end
  end
end
