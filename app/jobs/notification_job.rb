class NotificationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "This is notification job"
  end
end