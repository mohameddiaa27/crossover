class AgentSerializer < ActiveModel::Serializer
  # Attributes
  attributes :id, :name, :email, :type

  def type
  	'agent'
  end
  # Associations
  has_many :tickets
end
