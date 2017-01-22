class CustomerSerializer < ActiveModel::Serializer
  # Attributes
  attributes :id, :name, :email, :type

  def type
  	'customer'
  end
end
