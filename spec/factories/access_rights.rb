# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :access_right do
      user nil
      client nil
      roles "MyString"
    end
end