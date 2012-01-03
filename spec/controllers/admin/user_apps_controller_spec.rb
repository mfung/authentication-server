require 'spec_helper'

describe Admin::UserAppsController do
  include Devise::TestHelpers
  
  before (:each) do
      @user = FactoryGirl.create(:user)
      @role = FactoryGirl.create(:role_superuser)
      @user.roles << :superuser
      @user.save
      sign_in @user
  end
  
  # describe "GET 'create'" do
  #   it "returns http success" do
  #     get 'create'
  #     response.should be_success
  #   end
  # end
  # 
  # describe "GET 'destory'" do
  #   it "returns http success" do
  #     get 'destory'
  #     response.should be_success
  #   end
  # end
  # 
  # describe "GET 'role'" do
  #   it "returns http success" do
  #     get 'role'
  #     response.should be_success
  #   end
  # end
  # 
  # describe "GET 'status'" do
  #   it "returns http success" do
  #     get 'status'
  #     response.should be_success
  #   end
  # end
  # 
  # describe "GET 'destory_access_grants_and_rights'" do
  #   it "returns http success" do
  #     get 'destory_access_grants_and_rights'
  #     response.should be_success
  #   end
  # end

end
