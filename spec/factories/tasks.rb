FactoryBot.define do
  factory :task do
    title { "Test Task" }
    description { "Description Test Task" }
    status { "pending" }
    due_date { DateTime.tomorrow }
    user
  end
end
