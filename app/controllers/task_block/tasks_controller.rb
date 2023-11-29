module TaskBlock
  class TasksController < ApplicationController
    before_action :validate_user
    before_action :get_task, only: [:edit, :update, :show]

    def new
    end

    def create
      @task = Task.new(task_params)
      if @task.save
        flash[:notice] = "Task successfully added!"
        redirect_to "/task_block/tasks/#{@task.id}"
      else
        # flash[:alert] = "New post not added!"
        flash[:errors] = @task.errors
        redirect_to "/task_block/tasks/new"
      end
    end

    def edit
    end

    def update
      if @task.update(update_task_params)
        flash[:notice] = "Task successfully Updated!"
        # redirect_to "/"
        if @task.status == "pending"
          redirect_to "/task_block/tasks/pending_tasks"
        else
          redirect_to "/task_block/tasks/completed_tasks"
        end
      else
        flash[:errors] = @task.errors
        redirect_to "/task_block/tasks/#{@task.id}/edit"
      end
    end

    def show
    end

    def destroy
      task = Task.find(params[:id])
      if task.destroy
        flash[:notice] = "Task successfully deleted!"
        redirect_to "/"
      end
    end

    def trashed_tasks
      @trashed_tasks = current_user.tasks.only_deleted
    end

    def restore_task
      TaskBlock::Task.restore(params[:id])
      redirect_to "/task_block/tasks/trashed_tasks"
    end

    def permanent_destroy
      task = TaskBlock::Task.with_deleted.find(params[:id])
      if task.really_destroy!
        flash[:notice] = "Task successfully deleted!"
        redirect_to "/task_block/tasks/trashed_tasks"
      end
    end

    # def bulk_update_task
    #  Task.where(id: params[:task_ids]).update_all(status: "completed")
    # end

    def update_task
      Task.find(params[:task_id]).update(status: "completed")
    end

    def pending_tasks
      # @pending_tasks = current_user.tasks.where(status: "pending").order(created_at: :desc)
      @pending_tasks = current_user.tasks.where(status: "pending").order(:sort).all
    end

    def today_tasks
      @today_tasks = current_user.tasks.where(status: "pending", planned_date:  Date.today)
    end

    def upcoming_tasks
      # @upcoming_tasks = current_user.tasks.where(status: "pending").where('planned_date > ?', Date.today)
      @upcoming_tasks = current_user.tasks.where("status = ? AND planned_date > ?", 0, Date.today)
    end

    def completed_tasks
      tasks = current_user.tasks.where(status: "completed").order(updated_at: :desc)
      @completed_tasks = tasks.page(params[:page]).per(10)
    end

    def notification
      @notifications = current_user.notifications
    end

    def show_notification
      NotificationBlock::Notification.find(params[:id]).update(is_read: true, read_at: Time.now)
      redirect_to "/task_block/tasks/notification"
    end

    private

    def task_params
      params.require(:task).permit(:title, :description, :planned_date, :priority).merge(status: "pending", account_id: @current_user.id)
    end

    def update_task_params
      params.require(:task).permit(:title, :description, :status, :planned_date, :priority)
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
