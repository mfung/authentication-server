require 'spec_helper'

describe "admin_departments/show.html.haml" do
  before(:each) do
    @department = assign(:department, stub_model(Admin::Department,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
