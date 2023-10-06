module AccountBlock
  class Account < AccountBlock::ApplicationRecord
    self.table_name = :accounts

    has_one_attached :profile_pic
    validates :first_name, :last_name, presence: true
    validates :phone_number, :email, uniqueness: true, presence: true
    has_secure_password
    enum gender: [:male, :female, :other]

    has_many :tasks, class_name: 'TaskBlock::Task', dependent: :destroy
  end
end
