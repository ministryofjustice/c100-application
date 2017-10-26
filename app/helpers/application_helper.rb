module ApplicationHelper
  # Render a form_for tag pointing to the update action of the current controller
  def step_form(record, options = {}, &block)
    opts = {
      url: { controller: controller.controller_path, action: :update },
      method: :put
    }.merge(options)

    # Support for appending optional css classes, maintaining the default one
    opts.merge!(
      html: { class: dom_class(record, :edit) }
    ) do |_key, old_value, new_value|
      { class: old_value.values | new_value.values }
    end

    form_for record, opts, &block
  end

  # Render a back link pointing to the user's previous step
  def step_header
    capture do
      render partial: 'step_header', locals: {
        path: controller.previous_step_path
      }
    end + error_summary(@form_object)
  end

  def error_summary(form_object)
    return if form_object.nil?

    GovukElementsErrorsHelper.error_summary(
      form_object,
      translate('errors.error_summary.heading'),
      translate('errors.error_summary.text')
    )
  end

  def analytics_tracking_id
    ENV['GA_TRACKING_ID']
  end

  def title(page_title)
    content_for :page_title, [page_title.presence, t('generic.page_title')].compact.join(' - ')
  end

  # We send a notification to Sentry to be alerted about any missing page titles.
  # If this happens, the title will default to a generic title for the service
  def fallback_title
    exception = StandardError.new("page title missing: #{controller_name}##{action_name}")
    raise exception if Rails.application.config.consider_all_requests_local
    Raven.capture_exception(exception)

    title ''
  end
end
