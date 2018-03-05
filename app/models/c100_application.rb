class C100Application < ApplicationRecord
  enum status: {
    screening: 0,
    in_progress: 1,
    first_reminder_sent: 5,
    last_reminder_sent: 6,
    completed: 10,
  }

  belongs_to :user, optional: true

  has_one  :abduction_detail, dependent: :destroy
  has_one  :court_order,      dependent: :destroy
  has_one  :court_proceeding, dependent: :destroy
  has_one  :miam_exemption,   dependent: :destroy
  has_one  :screener_answers, dependent: :destroy

  has_many :abuse_concerns,   dependent: :destroy
  has_many :relationships,    dependent: :destroy

  # Remember, we are using UUIDs as the record IDs, we can't rely on ID sequential ordering
  has_many :people,      -> { order(created_at: :asc) }
  has_many :minors,      -> { order(created_at: :asc) }
  has_many :children,    -> { order(created_at: :asc) }, dependent: :destroy
  has_many :applicants,  -> { order(created_at: :asc) }, dependent: :destroy
  has_many :respondents, -> { order(created_at: :asc) }, dependent: :destroy

  has_many :other_children, -> { order(created_at: :asc) }, dependent: :destroy
  has_many :other_parties,  -> { order(created_at: :asc) }, dependent: :destroy

  scope :not_completed, -> { where.not(status: :completed) }
  scope :with_owner,    -> { where.not(user: nil) }

  has_value_object :user_type
  has_value_object :concerns_contact_type

  def confidentiality_enabled?
    address_confidentiality.eql?(GenericYesNo::YES.to_s)
  end

  def has_safety_concerns?
    [
      domestic_abuse,
      risk_of_abduction,
      children_abuse,
      substance_abuse,
      other_abuse
    ].any? { |concern| concern.eql?(GenericYesNo::YES.to_s) }
  end
end
