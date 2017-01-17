class AuthenticationToken < ApplicationRecord

	# Associations
  belongs_to :account, polymorphic: true
end
