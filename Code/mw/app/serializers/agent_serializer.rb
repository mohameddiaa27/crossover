class AgentSerializer < ActiveModel::Serializer
  # Attributes
  attributes :id, :name

  # Associations
  has_many :tickets
end