# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :department, :class => Admin::Department do
      name "Sales"
    end
end