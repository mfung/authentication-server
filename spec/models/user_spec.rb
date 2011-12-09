require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  before :each do
    @user = FactoryGirl.build(:user)
    @user_attr = FactoryGirl.attributes_for(:user)
  end
  
  it "should create a new valid user" do
    user = User.create(@user_attr)
    User.first.should eq(user)
  end
  
  it "should not allow duplicate email addresses" do
    user = User.create(@user_attr)
    user2 = User.new(@user_attr)
    user2.should_not be_valid
    user2.should have(1).error_on(:email)
    user2.errors[:email].should include("has already been taken")
  end
  
  it "should be able to assign clients to users" do
    user = FactoryGirl.build(:user)
    app = FactoryGirl.build(:client)
    user.clients << app
    user.save
    user.clients.should have(1).client
  end
  
  it "should create a new user with its status as 'Active'" do
    user = FactoryGirl.build(:user)
    user.status = ''
    user.save
    user.status.should eq('Active')
  end
end
