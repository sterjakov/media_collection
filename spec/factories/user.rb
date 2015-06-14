FactoryGirl.define do
  factory :user do
    email "test@example.com"
    password "please123"
    role "author"
  end

  factory :user_1, class: User do
    email "test_1@example.com"
    password "please123_1"
    role "author"
  end
end