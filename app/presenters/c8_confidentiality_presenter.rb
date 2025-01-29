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
    when :full_address, :residence_history
      contact_details_private.include? ContactDetails::ADDRESS.to_s
    when :home_phone
      contact_details_private.include? ContactDetails::HOME_PHONE.to_s
    when :mobile_phone
      contact_details_private.include? ContactDetails::MOBILE.to_s
    when :email
      contact_details_private.include? ContactDetails::EMAIL.to_s
    end
  end

  def replacement_answer
    @_replacement_answer ||= self.class.replacement_answer
  end
end
