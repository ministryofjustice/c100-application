class BackofficeUser < ApplicationRecord
  attribute :email, :normalised_email
  validates :email, email: true, allow_blank: false

  scope :active, -> { where(active: true) }
end
