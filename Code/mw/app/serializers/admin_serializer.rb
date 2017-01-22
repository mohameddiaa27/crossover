class AdminSerializer < ActiveModel::Serializer
  # Attributes
  attributes :id, :name, :email, :type

  def type
  	'admin'
  end

end
