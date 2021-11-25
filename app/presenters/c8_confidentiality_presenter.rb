class C8ConfidentialityPresenter < SimpleDelegator
  def self.replacement_answer
    I18n.translate!('shared.c8_confidential_answer')
  end

  def method_missing(name, *args, &block)
    confidential_detail?(name, super) ? replacement_answer : super
  end

  private

  # This is just to remove from the logs:
  #   `warning: delegator does not forward private method #to_ary`
  def to_ary
    [self]
  end

  def confidential_detail?(attribute, value)
    return unless value.present?
    case attribute
    when :full_address
      try(:residence_keep_private) == 'yes'
    when :home_phone
      try(:phone_keep_private) == 'yes'
    when :mobile_phone
      try(:mobile_keep_private) == 'yes'
    when :email
      try(:email_keep_private) == 'yes'
    end
  end

  def replacement_answer
    @_replacement_answer ||= self.class.replacement_answer
  end
end
