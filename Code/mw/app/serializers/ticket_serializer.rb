class TicketSerializer < ActiveModel::Serializer

  # Attributes
  attributes :id, :title, :body, :status, :created_at, :closed_at

  # Associations
  has_many :comments
  belongs_to :customer
  belongs_to :agent
end
