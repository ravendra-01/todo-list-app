require 'sidekiq-scheduler'

class NotificationScheduler
  include Sidekiq::Worker

  def perform
    users = AccountBlock::Account.joins(:tasks).where('tasks.planned_date' => Date.today, 'tasks.status' => 0).uniq
    users.each do |user|
      pending_task = user.tasks.where(planned_date: Date.today, status: "pending")
      notification = NotificationBlock::Notification.new(
              headings: "You have #{pending_task.count} pending tasks for the day",
              contents: "",
              account_id: user.id
              )
      notification.save
      puts "You have #{pending_task.count} pending tasks for the day"
    end
  end

end