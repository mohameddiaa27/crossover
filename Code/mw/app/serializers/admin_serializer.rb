class AdminSerializer < ActiveModel::Serializer
  # Attributes
  attributes :id, :name, :type

  def type
  	'admin'
  end

end
