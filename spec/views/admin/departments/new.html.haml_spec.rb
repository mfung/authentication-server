# require 'spec_helper'
# 
# describe "admin_departments/new.html.haml" do
#   before(:each) do
#     assign(:department, stub_model(Admin::Department,
#       :name => "MyString"
#     ).as_new_record)
#   end
# 
#   it "renders new department form" do
#     render
# 
#     # Run the generator again with the --webrat flag if you want to use webrat matchers
#     assert_select "form", :action => admin_departments_path, :method => "post" do
#       assert_select "input#department_name", :name => "department[name]"
#     end
#   end
# end
