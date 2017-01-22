class CommentSerializer < ActiveModel::Serializer
  # Attributes
  attributes :id, :body, :created_at

  # Associations
  belongs_to :account
end
