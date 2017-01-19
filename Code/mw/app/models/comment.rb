class Comment < ApplicationRecord

  # Associations
  belongs_to :ticket
  belongs_to :account, polymorphic: true

  # Validations
  validates :body, length: { minimum: 1 }
  validates :account, presence: true
end
