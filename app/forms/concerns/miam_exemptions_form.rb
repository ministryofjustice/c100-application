module MiamExemptionsForm
  extend ActiveSupport::Concern
  include HasOneAssociationForm
  include ActiveModel::Validations::Callbacks

  included do
    has_one_association :miam_exemption
    validate :at_least_one_checkbox_validation
    validate :none_must_be_exclusive
    before_validation :valid_options
  end

  class_methods do
    attr_accessor :attribute_name, :allowed_values

    def setup_attributes_for(value_object, attribute_name:)
      self.attribute_name = attribute_name
      self.allowed_values = value_object.string_values

      attribute attribute_name, Array[String]
      attribute :exemptions_collection, Array[String]
    end
  end

  # Custom getter and setter so we always have both attributes synced,
  # as one attribute is the main categories and the other are subcategories.
  # Needed to make the revealing check boxes work nice with errors, etc.
  #
  def exemptions_collection
    super | public_send(self.class.attribute_name)
  end

  def exemptions_collection=(values)
    super(Array(values) | Array(public_send(self.class.attribute_name)))
  end

  private
  
  # We filter out `group_xxx` items, as the purpose of these are to present the exemptions
  # in groups for the user to show/hide them, and are not really an exemption by itself.
  #
  def valid_options
    valid_collection = []
    valid_collection << (remove_group_police_values << remove_group_court_values << remove_group_specialist_values << remove_group_local_authority_values << remove_group_da_service_values).flatten!
  end

  def remove_group_police_values
    return [] unless exemptions_collection.include?("group_police")

    exemptions_collection.grep(/\Apolice_/)
  end

  def remove_group_court_values
    return [] unless exemptions_collection.include?("group_court")

    exemptions_collection.grep(/\Acourt_/)
  end

  def remove_group_specialist_values
    return [] unless exemptions_collection.include?("group_specialist")

    exemptions_collection.grep(/\Aspecialist_/)
  end

  def remove_group_local_authority_values
    return [] unless exemptions_collection.include?("group_local_authority")

    exemptions_collection.grep(/\Alocal_authority_/)
  end

  def remove_group_da_service_values
    return [] unless exemptions_collection.include?("group_da_service")

    exemptions_collection.grep(/\Ada_service_/)
  end

  def none_must_be_exclusive
    return unless selected_options.grep(/_none$/).any? && selected_options.length > 1
    errors.add(self.class.attribute_name, :none_not_exclusive)
  end

  def selected_options
    valid_options & self.class.allowed_values
  end

  def at_least_one_checkbox_validation
    errors.add(self.class.attribute_name, :blank) unless valid_options.any?
  end

  def persist!
    raise BaseForm::C100ApplicationNotFound unless c100_application

    record_to_persist.update(
      self.class.attribute_name => selected_options
    )
  end
end
