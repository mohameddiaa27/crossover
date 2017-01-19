class Ticket < ApplicationRecord

	# Attributes
	enum status: [:initiated, :assigned, :solved]

	# Associations
  belongs_to :customer
  belongs_to :agent
  has_many :comments
  has_many :preview_comments, -> { limit(10) }, class_name: Comment

  # Validations
  validates :customer, presence: true
  validates :title, length: { in: 6..100 }
  validates :body, length: { minimum: 10 }

  # Scopes
  scope :for_customer, ->(customer_id) { where(customer_id: customer_id) }
  scope :for_agent, ->(agent_id) { where(agent_id: agent_id) }

  # Methods
  def assign!(agent)
    return false unless self.agent.nil?
  	self.agent = agent
  	self.assigned!
  end
end
