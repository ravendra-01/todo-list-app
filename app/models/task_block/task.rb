module TaskBlock
  class Task < TaskBlock::ApplicationRecord
    self.table_name = :tasks
    acts_as_paranoid

    validates :title, :description, presence: true
    enum status: [:pending, :completed]

    belongs_to :account, class_name: 'AccountBlock::Account'
  end
end
