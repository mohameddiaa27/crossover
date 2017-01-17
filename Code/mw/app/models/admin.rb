class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :trackable, :validatable, :token_authenticatable

  has_many :authentication_tokens, as: :account
  has_many :comments, as: :account
end
