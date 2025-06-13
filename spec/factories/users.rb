FactoryBot.define do
  factory :user do
    name { "Test User" }
    email { "teste@example.com" }
    password { "123456" }
  end
end
