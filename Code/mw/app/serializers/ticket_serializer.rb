class TicketSerializer < ActiveModel::Serializer

  # Attributes
  attributes :id, :title, :body

  # Associations
  has_many :preview_comments, key: :comments
  belongs_to :customer
  belongs_to :agent
end
