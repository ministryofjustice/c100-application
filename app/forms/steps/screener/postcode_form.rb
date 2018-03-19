class FullUkPostcodeValidator < ActiveModel::EachValidator
  def parsed_postcode(postcode)
    UKPostcode.parse(postcode)
  end

  def validate_each(record, attribute, value)
    entries = value.split('\n').reject(&:blank?).compact
    entries.each do |entry|
      unless parsed_postcode(entry).full_valid?
        record.errors[attribute] << I18n.t(:invalid, scope: [:errors, :attributes, :children_postcodes])
      end
    end
  end
end

module Steps
  module Screener
    class PostcodeForm < BaseForm
      include HasOneAssociationForm

      has_one_association :screener_answers

      attribute :children_postcodes, String
      validates :children_postcodes, full_uk_postcode: true

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        record_to_persist.update(
          children_postcodes: children_postcodes
        )
      end
    end
  end
end
