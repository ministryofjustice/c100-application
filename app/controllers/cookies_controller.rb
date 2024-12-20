class CookiesController < ApplicationController
  include CookiesHelper
  include ApplicationHelper

  def update(cookie_expiry: Rails.application.config.x.cookie_expiry)
    cookie_form.assign_attributes cookie_params.merge(seen: true)
    cookies['cookie_setting'] = { value: cookie_form.to_json, expires: cookie_expiry }
    redirect_to cookies_path, allow_other_host: true, flash: { cookie_success: "You've set your cookie preferences" }
  end

  def create(cookie_expiry: Rails.application.config.x.cookie_expiry)
    cookie_form.assign_attributes cookie_params.merge(seen: true)
    cookies['cookie_setting'] = { value: cookie_form.to_json, expires: cookie_expiry }
    redirect_to path_only(params.dig(:cookie, :return_path)), allow_other_host: true,
                flash: { cookie_banner_confirmation: t("cookie_banner.confirmation_message.#{cookie_form.usage}") }
  end

  private

  def cookie_params
    params.require(:cookie).permit(:usage)
  end
end
