FactoryBot.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    email { [generate(:email)] }
    password { 'secret-password' }
  end
end