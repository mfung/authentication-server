# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :name do |n|
    "Application #{n}"
  end
  
  sequence :app_id do |n|
    "app_id_#{n}"
  end
  
  sequence :app_secret do |n|
    "app_secret_#{n}"
  end
  
  sequence :uri do |n|
    "http://uri_#{n}/"
  end
  
  sequence :remote_roles_path do |n|
    "/path_#{n}/"
  end
  
  factory :client do
    name
    app_id
    app_secret
    uri
    remote_roles_path
  end
end