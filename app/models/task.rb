class Task < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
  enum status: { todo: 0, done: 1, doing: 2 }

  belongs_to :user
end
