class CommentSerializer < ActiveModel::Serializer
  # Attributes
  attributes :id, :body

  # Associations
  belongs_to :account
end
