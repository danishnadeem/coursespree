OmniAuth.config.full_host = "https://shrouded-plateau-9637.herokuapp.com"
#http://localhost:3000/  http://tutorsprout.com
OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
  :scope => 'email,user_birthday,read_stream'#, :display => 'popup'
end