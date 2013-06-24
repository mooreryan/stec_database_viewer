FactoryGirl.define do
  factory :user do
    name     "Cliff Lee"
    email    "cliff.lee@phillies.com"
    password "shutout"
    password_confirmation "shutout"
  end
end
