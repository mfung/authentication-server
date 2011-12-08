require File.dirname(__FILE__) + '/../spec_helper'

describe Client do
  before :each do
    @client = FactoryGirl.build(:client)
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
  
end
