# OmniAuth configuration
# Build the callback host dynamically from the incoming request
OmniAuth.config.full_host = lambda do |env|
  scheme = env['rack.url_scheme']
  host = env['HTTP_HOST'] || env['SERVER_NAME']
  "#{scheme}://#{host}"
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV.fetch('GOOGLE_OAUTH_CLIENT_ID', nil), ENV.fetch('GOOGLE_OAUTH_CLIENT_SECRET', nil), {
    provider_ignores_state: true
  }
end
