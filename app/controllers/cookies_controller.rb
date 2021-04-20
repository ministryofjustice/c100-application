class CookiesController < ApplicationController
  include CookiesHelper

  def update(cookie_expiry: Rails.application.config.x.cookie_expiry)
    cookie_form.assign_attributes cookie_params.merge(seen: true)
    cookies['cookie_setting'] = { value: cookie_form.to_json, expires: cookie_expiry }
    redirect_to cookies_path, flash: { cookie_success: "You've set your cookie preferences" }
  end

  def create(cookie_expiry: Rails.application.config.x.cookie_expiry)
    cookie_form.assign_attributes cookie_params.merge(seen: true)
    cookies['cookie_setting'] = { value: cookie_form.to_json, expires: cookie_expiry }
    redirect_to(return_path,
                flash: { cookie_banner_confirmation: t("cookie_banner.confirmation_message.#{cookie_form.usage}") })
  end

  private

  def return_path
    uri = URI.parse(params.dig(:cookie, :return_path))
    { only_path: true, path: uri.path, query: uri.query }
  end

  def cookie_params
    params.require(:cookie).permit(:usage)
  end
end
