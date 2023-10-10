module TaskBlock
  class TasksController < ApplicationController
    before_action :validate_user

    def new
    end

    def create
      @task = Task.new(params.require(:task).permit(:title, :description).merge(status: "pending", account_id: @current_user.id))
      if @task.save
        flash[:notice] = "Task successfully added!"
        # redirect_to "/users/#{@user.id}"
        redirect_to "/"
      else
        # flash[:alert] = "New post not added!"
        # redirect_to "/"
        flash[:errors] = @task.errors
        redirect_to "/task_block/tasks/new"
      end
    end

    def edit
      # task = Task.find params[:id]
      # if task
      #   task.update(status:"completed")
      #   flash[:notice] = "Task successfully Updated!"
      #   # redirect_to "/users/#{@user.id}"
      #   redirect_to "/"
      # else
      #   flash[:alert] = "Task not Updated!"
      #   redirect_to "/"
      # end
    end

    private

    def validate_user
      redirect_to "/account_block/accounts/new" unless current_user
    end
  end
end
