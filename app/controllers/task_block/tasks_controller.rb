module TaskBlock
  class TasksController < ApplicationController
    before_action :validate_user
    before_action :get_task, only: [:edit, :update]

    def new
    end

    def create
      @task = Task.new(task_params)
      if @task.save
        flash[:notice] = "Task successfully added!"
        redirect_to "/"
      else
        # flash[:alert] = "New post not added!"
        flash[:errors] = @task.errors
        redirect_to "/task_block/tasks/new"
      end
    end

    def edit
    end

    def update
      byebug
      if @task.update(update_task_params)
        flash[:notice] = "Task successfully Updated!"
        redirect_to "/"
      else
        flash[:errors] = @task.errors
        redirect_to "/task_block/tasks/#{@task.id}/edit"
      end
    end

    private

    def task_params
      params.require(:task).permit(:title, :description).merge(status: "pending", account_id: @current_user.id)
    end

    def update_task_params
      params.require(:task).permit(:title, :description, :status)
    end

    def get_task
      @task = Task.find params[:id]
      redirect_to "/task_block/tasks/new" unless @task
    end

    def validate_user
      redirect_to "/account_block/accounts/new" unless current_user
    end
  end
end
