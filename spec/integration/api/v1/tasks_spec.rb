require "swagger_helper"

RSpec.describe "Tasks", type: :request do
  let(:user) { create(:user) }
  let(:Authorization) { auth_header(user)["Authorization"] }

  path "/api/v1/tasks" do
    get("List user tasks") do
      tags "Tasks"
      produces "application/json"
      security [ bearerAuth: [] ]

      response "200", "list tasks" do
        let(:task) { create(:task, user: user) }

        schema type: :array,
          items: {
            "$ref" => "#/components/schemas/task"
          }

        run_test!
      end
    end
  end

  path "/api/v1/tasks/{id}" do
    get("List task by ID") do
      tags "Tasks"
      produces "application/json"
      security [ bearerAuth: [] ]
      parameter name: :id, in: :path

      response "200", "list task" do
        let(:task) { create(:task, user: user) }
        let(:id) { task.id }

        schema "$ref" => "#/components/schemas/task"

        run_test!
      end

      response "404", "task not found" do
        let(:id) { 99 }

        schema "$ref" => "#/components/schemas/errors"

        run_test!
      end
    end
  end

  path "/api/v1/tasks" do
    post("Create task") do
      tags "Tasks"
      consumes "application/json"
      produces "application/json"
      security [ bearerAuth: [] ]
      parameter name: :new_task, in: :body, schema: { "$ref" => "#/components/schemas/new_task" }

      response "201", "create a task" do
        let(:new_task) { { title: "Task title", description: "Description 123", status: 0, due_date: DateTime.tomorrow } }

        schema "$ref" => "#/components/schemas/task"

        run_test!
      end

      response "422", "invalid fields" do
        let(:new_task) { { title: nil, description: "Description 123", status: 0, due_date: DateTime.tomorrow } }

        schema "$ref" => "#/components/schemas/errors"

        run_test!
      end
    end
  end

  path "/api/v1/tasks/{id}" do
    put("Update task") do
      tags "Tasks" 
      consumes "application/json"
      produces "application/json"
      security [ bearerAuth: [] ]
      parameter name: :id, in: :path
      parameter name: :task_body, in: :body, schema: { "$ref" => "#/components/schemas/new_task" }

      response "200", "update task" do
        let(:task) { create(:task, user: user) }
        let(:id) { task.id }
        let(:task_body) { { title: "Updated title" } }

        schema "$ref" => "#/components/schemas/task"

        run_test!
      end
    end
  end
end
