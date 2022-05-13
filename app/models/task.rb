class Task < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  validates :status, inclusion: [true, false]

  belongs_to :user
end
