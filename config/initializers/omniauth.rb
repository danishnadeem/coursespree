OmniAuth.config.full_host = "http://tutorsprout.com"
#http://localhost:3000/  http://tutorsprout.com
OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
  :scope => 'email,user_birthday,read_stream'#, :display => 'popup'
end