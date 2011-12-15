# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
    "user_#{n}@gmail.com"
  end
  
  factory :user do
    first_name 'Bob'
    last_name 'Smith'
    email
    department { %w{Sales Production CS HR}.sample }
    password 'password'
    password_confirmation 'password'
    roles :factory => :role_superuser
  end
  
  factory :role do
  end
  
  factory :role_superuser, :parent => :role do
    name 'superuser'
  end
  
  factory :role_admin, :parent => :role do
    name 'admin'
  end
  
  factory :role_user, :parent => :role do
    name 'user'
  end
  
  factory :user_role do |ur|
    ur.association :user
    ur.association :role
  end
  
end