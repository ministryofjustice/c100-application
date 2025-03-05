# Note: this will setup a session-only cookie, which will expire as soon as
# the browser is closed.
#
# While the browser is open, there is a JS mechanism to alert the user if
# there is no activity (i.e. server-side requests) for a prolonged period
# of time (see `config.x.session.expires_in_minutes` and
# `config.x.session.warning_when_remaining` for the time values, and
# `/assets/javascripts/modules/session-timeout.js` for the details).
#
# As we can't rely only on JS, there is also a request-based check to expire
# the session if the cookie is too old (see `/concerns/security_handling.rb`).
#
# Rails.application.config.session_store :mem_cache_store, key: '_c100_application_session', secure: Rails.env.production?
if Rails.env.test?
  Rails.application.config.session_store :cookie_store, key: '_c100_application_session', secure: Rails.env.production?
else
  redis_url = { url: ENV["REDIS_URL"] || "redis://localhost:6379/1" }
  Rails.application.config.session_store :redis_store, url: redis_url,
                                            key: '_c100_application_session',
                                            secure: Rails.env.production?,
                                            expire_after: 30.days
end
