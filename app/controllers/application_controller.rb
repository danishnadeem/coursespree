class ApplicationController < ActionController::Base
  protect_from_forgery
  def sha1(string)
    Digest::SHA1.hexdigest(string)
  end
  

end
