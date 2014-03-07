FactoryGirl.define do
  factory :user do
    name     "Yo Honey Singh"
    sequence(:email) {|n| "user#{n}@factory.com" }
    password "foobar"
    password_confirmation "foobar"
  end
end