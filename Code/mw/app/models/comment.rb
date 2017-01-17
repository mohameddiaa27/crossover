class Comment < ApplicationRecord

  # Associations
  belongs_to :ticket
  belongs_to :account, polymorphic: true
end
