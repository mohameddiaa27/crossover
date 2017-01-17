class Ticket < ApplicationRecord

	# Attributes
	enum status: [:initiated, :assigned, :solved]

	# Associations
  belongs_to :customer
  belongs_to :agent

  # Scopes
  scope :for_customer, ->(customer_id) { where(customer_id: customer_id) }
  scope :for_agent, ->(agent_id) { where(agent_id: agent_id) }

  # Methods
  def assign!(account)
  	self.agent = account
  	self.assigned!
  end
end
