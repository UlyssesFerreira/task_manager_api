class Task < ApplicationRecord
  has_paper_trail
  belongs_to :user

  enum :status, {
    pending: 0,
    in_progress: 1,
    done: 2
  }

  validates :title, presence: true
end
