OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
  ENV['GOOGLE_CLIENT_ID'],
  ENV['GOOGLE_CLIENT_SECRET'],
  { 
    scope: "userinfo.email, userinfo.profile, calendar",
    access_type: 'offline', 
    include_granted_scopes: 'true', 
    approval_prompt: 'force',
    prompt: 'consent'
  }
end
