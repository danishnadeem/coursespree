# Allow the metal piece to run in isolation
require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)

class Ipn_Notification
  def self.call(env)
    if env["PATH_INFO"] =~ /^\/ipn_notification/
      request = Rack::Request.new(env)
      params = request.params
      
      ipn = PaypalAdaptive::IpnNotification.new
      ipn.send_back(env['rack.request.form_vars'])
      if ipn.verified?
        #mark transaction as completed in DB
      Meeting.find_by_paykey(params[:pay_key])
      m.paid = true
      m.save
      
      puts "here goes test info"
      puts params.inspect unless params.nil?
      puts data.inspect unless data.nil?
      if params.nil?
        puts "params is not availabile"
      elsif data.nil?
        puts "data not ok"
      else
        puts "all good"
      end
      
      

        #data base operation end
        output = "Verified."
      else
        output = "Not Verified."
      end

      [200, {"Content-Type" => "text/html"}, [output]]
    else
      [404, {"Content-Type" => "text/html"}, ["Not Found"]]
    end
  end
  
end