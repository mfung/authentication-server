# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :access_grant do
      code "MyString"
      access_token "MyString"
      refresh_token "MyString"
      access_token_expires_at "2011-12-01 17:04:53"
      user_id 1
      client_id 1
    end
end