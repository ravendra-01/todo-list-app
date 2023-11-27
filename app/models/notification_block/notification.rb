module NotificationBlock
  class Notification < NotificationBlock::ApplicationRecord
    self.table_name = :notifications

    validates :headings, :contents, presence: true

    belongs_to :account, class_name: 'AccountBlock::Account'
  end
end
