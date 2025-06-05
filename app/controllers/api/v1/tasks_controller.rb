module Api    
  module V1  
    class TasksController < ApplicationController
      before_action :set_task, only: [:show, :update, :destroy, :history, :restore_version]

      def index
        tasks = current_user.tasks.order(created_at: :desc)   
        render json: tasks, status: :ok 
      end

      def show
        render json: @task, status: :ok
      end

      def create
        task = current_user.tasks.build(task_params)
        if task.save
          render json: task, status: :created
        else
          render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @task.update(task_params)
          render json: @task, status: :ok
        else
          render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @task.destroy
        render :not_content
      end

      def history
        history = @task.versions.map do |version|
          {
            version_id: version.id,
            event: version.event,
            changed_by: User.find_by(id: version.whodunnit)&.name,
            changes: version.changeset,
            changed_at: version.created_at
          }
        end
        render json: history, status: :ok
      end

      def restore_version
        version = @task.versions.find_by(id: params[:version_id])
        previous_version = version.reify
        if previous_version.save
          render json: previous_version, status: :ok
        else
          render json: { errors: previous_version.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_task
        @task = current_user.tasks.find_by(id: params[:id])
        render json: { error: "Task not found" }, status: :not_found if @task.blank?
      end

      def task_params
        params.require(:task).permit(:title, :description, :status, :due_date)
      end
    end
  end
end
