class ReviewReply < ApplicationRecord
  belongs_to :review
  belongs_to :seller, class_name: "User"

  validates :comment, presence: true
end
