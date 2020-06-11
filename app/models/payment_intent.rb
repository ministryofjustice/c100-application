class PaymentIntent < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :c100_application

  # URLs are one-time use only. Once accessed, they are invalidated.
  def return_url
    validate_payment_url(self, nonce: init_nonce)
  end

  def revoke_nonce!
    update_column(:nonce, nil)
  end

  private

  def init_nonce
    update_column(:nonce, SecureRandom.hex(8)) && nonce
  end
end
