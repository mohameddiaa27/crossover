class Comment < ApplicationRecord

  # Associations
  belongs_to :ticket
  belongs_to :account, polymorphic: true

  # Validations
  validates :body, length: { minimum: 1 }
  validates :account, presence: true
  validate :ownership

  def ownership
		case self.account_type
		when 'customer'
			unless self.ticket.customer == account
				errors.add(:account_id, "can't comment on this ticket")
			end
		when 'agent'
			unless self.ticket.agent == account
				errors.add(:account_id, "can't comment on this ticket")
			end
  	end
  end
end
