# Be sure to restart your server when you modify this file.

# Configure parameters to be partially matched (e.g. passw matches password) and filtered from the log file.
# Use this to limit dissemination of sensitive information.
# See the ActiveSupport::ParameterFilter documentation for supported notations and behaviors.
Rails.application.config.filter_parameters += [
  :email,
  :password,
  :details,
  :description,
  :reference,
  :solicitor_account_number,
  :current_location,
  :children_names,
  :case_number,
  :order_types,
  :first_name,
  :last_name,
  :full_name,
  :previous_name,
  :postcode,
  :address_data,
  :address_line,
  :selected_address,
  :phone,
  :fax_number,
  :residence_history,
  :recipient,
  :to,
  :declaration_signee,
]
