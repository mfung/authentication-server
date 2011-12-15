require 'spec_helper'

describe "admin_departments/index.html.haml" do
  before(:each) do
    assign(:admin_departments, [
      stub_model(Admin::Department,
        :name => "Name"
      ),
      stub_model(Admin::Department,
        :name => "Name"
      )
    ])
  end

  it "renders a list of admin_departments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
