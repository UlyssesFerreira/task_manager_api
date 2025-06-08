require "swagger_helper"

RSpec.describe "Tasks", type: :request do
  path "/api/v1/tasks" do
    get("List user tasks") do
      tags "Tasks"
      produces "application/json"
      security [ bearerAuth: [] ]

      response "200", "list tasks" do
        let(:user) { create(:user) }
        let(:Authorization) { auth_header(user)["Authorization"] }
        let(:task) { create(:task) }

        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              title: { type: :string },
              description: { type: :string },
              status: { type: :string },
              due_date: { type: :string, format: :date_time },
              user_id: { type: :integer }
            },
            required: ["id", "title", "description", "status", "due_date", "user_id"]
          }

        run_test!
      end
    end
  end
end
