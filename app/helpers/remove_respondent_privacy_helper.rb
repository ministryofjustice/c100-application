module RemoveRespondentPrivacyHelper
  def remove_privacy_if_single_respondent(c100_application)
    return unless c100_application.respondents.size == 1

    c100_application.respondents.each do |respondent|
      respondent.update(are_contact_details_private: nil)
    end
  end
end
