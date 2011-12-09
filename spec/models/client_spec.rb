require File.dirname(__FILE__) + '/../spec_helper'

describe Client do
  before :each do
    @client = FactoryGirl.build(:client)
    @client_attr = FactoryGirl.attributes_for(:client)
  end
  
  it "should create a new client" do
    client = Client.create!(:name => 'Test')
    Client.first.should eq(client)
  end
  
  it "should not create a new client with out a name" do
    client = Client.new
    client.attributes = {:name => ''}
    client.should_not be_valid
    client.should have(1).error_on(:name)
    client.errors[:name].should include("can't be blank")
  end
  
  it "should create an auto generated app_id 32 characters long (16 hex)" do
    client = Client.create(@client_attr)
    client.app_id.size.should == 32
  end
  
  it "should create an auto generated app_secret 32 characters long (16 hex)" do
    client = Client.create(@client_attr)
    client.app_secret.size.should == 32
  end
  
  it "should be able to filter a remote_roles_path and add / to beginning on update" do
    client = Client.create(@client_attr)
    client.update_attributes({:remote_roles_path => "api/roles"})
    client.save
    client.remote_roles_path.should eq("/api/roles")
  end
  
  it "should be able to filter a remote_roles_path and add / to beginning on create" do
    @client_attr[:remote_roles_path] = 'api/roles'
    client = Client.create(@client_attr)
    client.remote_roles_path.should eq("/api/roles")
  end
  
  it "should return a string in the form of id: name for collections when name_with_id" do
    client = Client.create(@client_attr)
    client.name_with_id.should eq("#{client.id}: #{client.name}")
  end
  
  it "should return the correct client model when I give it an app_id and app_secret" do
    client = Client.create(@client_attr)
    client.app_id = 'app_id'
    client.app_secret = 'app_secret'
    client.save
    Client.authenticate('app_id', 'app_secret').should eq(client)
  end
end
