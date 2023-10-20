module ApplicationInquiryMethods
  YES_ANSWER = GenericYesNo::YES.to_s

  def online_payment?
    payment_type.eql?(PaymentType::ONLINE.to_s)
  end

  def consent_order?
    consent_order.eql?(YES_ANSWER)
  end

  def child_protection_cases?
    child_protection_cases.eql?(YES_ANSWER)
  end

  def confidentiality_enabled?
    applicants.where(are_contact_details_private: GenericYesNo::YES.to_s).any?
  end

  def has_solicitor?
    has_solicitor.eql?(YES_ANSWER)
  end

  def has_safety_concerns?
    [
      domestic_abuse,
      risk_of_abduction,
      children_abuse,
      substance_abuse,
      other_abuse
    ].any? { |concern| concern.eql?(YES_ANSWER) }
  end

  def mark_as_urgent?
    urgent_hearing == 'yes'
  end
end
