class Ticket < ApplicationRecord

  # Attributes
  enum status: [:initiated, :assigned, :solved]

  # Associations
  belongs_to :customer
  belongs_to :agent
  has_many :comments, dependent: :destroy

  # Validations
  validates :customer, presence: true
  validates :title, length: { in: 6..100 }
  validates :body, length: { minimum: 10 }
  validate :verify_admin
  validate :verify_status

  # Scopes
  default_scope -> { order(created_at: :desc) }
  scope :for_customer, ->(customer_id) { where(customer_id: customer_id) }
  scope :for_agent, ->(agent_id) { where(agent_id: agent_id) }

  # Agent Can not be changed
  def verify_admin
    if self.agent_id_changed? and ["assigned", "solved"].include?(self.status_was)
      errors.add(:agent_id, "can't be changed")
    end
  end

  # Status Can not be changed to previous state
  def verify_status
    case self.status.to_sym
    when :initiated
      return status_error if ["assigned", "solved"].include?(self.status_was)
      return status_error if self.agent_id.present?
    when :assigned
      return status_error if "solved" == self.status_was
    when :solved
      return status_error if self.agent_id_changed? || "solved" == self.status_was
    end
  end

  def status_error
    errors.add(:status, "can't be changed to #{self.status}")
  end

  def agent_error
    errors.add(:agent_id, "can't be changed")
  end
end
