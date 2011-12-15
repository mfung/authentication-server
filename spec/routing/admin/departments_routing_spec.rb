require "spec_helper"

describe Admin::DepartmentsController do
  describe "routing" do

    it "routes to #index" do
      get("/admin_departments").should route_to("admin_departments#index")
    end

    it "routes to #new" do
      get("/admin_departments/new").should route_to("admin_departments#new")
    end

    it "routes to #show" do
      get("/admin_departments/1").should route_to("admin_departments#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin_departments/1/edit").should route_to("admin_departments#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin_departments").should route_to("admin_departments#create")
    end

    it "routes to #update" do
      put("/admin_departments/1").should route_to("admin_departments#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin_departments/1").should route_to("admin_departments#destroy", :id => "1")
    end

  end
end
