class MeetingsController < ApplicationController
  #protect_from_forgery :except => :ipn_notification
  before_filter :authticate, :except => :ipn_notification
  def authticate
    unless User.find_by_id(session[:user_id])
      flash[:notice] = "Please log in."
      redirect_to :controller => 'admin', :action => 'login'
    end    
  end
  
  def accept
    
  end
  
  def ipn_notification
    puts "here goes inspect method"
    puts params.inspect
    #puts ("status is : " + params["status"]).inspect
    params
    if !params.nil?
    puts "here goes inspect method2"
    puts params.inspect      
      params = "cmd=_notify-validate&#{params}"
      puts "here goes inspect method 3"
      puts params.inspect
      #to be tested
      #m = Meeting.find_by_paykey(params[:pay_key])
      #m.paid = true
      #m.save
    end
    
    #  uri = "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_notify-validate" + msg_body
    #  response = Net::HTTP.get(URI.parse(uri))    
    
  end
  def canceled_payment_request
  end
  
  def completed_payment_request
  end  
  
  
  def payment

      if request.post? && !params[:mid].nil?
        #redirect_to(:back, notice: params[:oid])
        
        if !Meeting.find(params[:mid])
          redirect_to(:back, notice: "invalid order")
          return
        end
        meeting = Meeting.find(params[:mid])
        receiver1 = "seller_1343182998_biz@gmail.com"
        receiver2 = meeting.tutor.user.paypalEmail
        
        meeting_price =meeting.tutor.rate*meeting.tutor_availability.length
        ##site_commission = meeting_price*0.2 # not used
        price =  "%.2f" % meeting_price
        ##commission = "%.2f" % site_commission #not used
        pay_request = PaypalAdaptive::Request.new
        serverbase = "http://198.101.226.133/"
        #serverbase = "http://localhost:3000/"
        
        data = {
              "returnUrl" => serverbase + "meetings/" + params[:mid].to_s, 
              "requestEnvelope" => {"errorLanguage" => "en_US"},
              "currencyCode"=>"USD",  
              "receiverList"=>{"receiver"=>[{"email"=>receiver2, "amount"=>price}]},
              "cancelUrl"=> serverbase + "meetings/" + params[:mid].to_s,
              "actionType"=>"PAY",
              "ipnNotificationUrl"=>serverbase + "ipn_notification"
              }
        
        pay_response = pay_request.pay(data)
        
        if pay_response.success?
          redirect_to pay_response.approve_paypal_payment_url
          #puts (pay_response['payKey'] + "test").inspect
          meeting.paykey = pay_response['payKey']
          #store paykey into the meeting data base 
          meeting.save
        else
          puts pay_response.errors.first['message']
          redirect_to failed_payment_url
        end        
        
        return
      end
  end
  
  def payment_made
    redirect_to '/'
  end
  
  def bbb_api_base_url
    "http://198.101.200.137/bigbluebutton/api/"
  end
  
  def sha1(string)
    Digest::SHA1.hexdigest(string)
  end
  
  # GET /meetings
  # GET /meetings.json
  def index
    if params[:type]=='requested'
      @meetings = Meeting.find_all_by_user_id(session[:user_id])
    elsif params[:type]=='pending'
      @meetings = Meeting.find(:all, :conditions=> ["tutor_id = ? and accept =?", Tutor.find_by_user_id(session[:user_id]).id, 0])
    elsif params[:type]=='past'
      @meetings = Meeting.find(:all, :conditions=> ["tutor_id = ? and accept =?", session[:user_id], 1])
    else
      @meetings = Meeting.all
    end

    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @meetings }
    end
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
    @meeting = Meeting.find(params[:id])
    if !params[:accept].nil? && params[:accept] == '1' && @meeting.tutor_id == session[:tutor_id]
      #only tutor for the meeting can accept the meeting
      @meeting.accept = 1
      @meeting.save
    elsif !params[:accept].nil? && params[:accept] == '1' && @meeting.tutor_id != session[:tutor_id]
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @meeting }
    end
  end

  # GET /meetings/new
  # GET /meetings/new.json
  def new
    @meeting = Meeting.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @meeting }
    end
  end

  # GET /meetings/1/edit
  def edit
    @meeting = Meeting.find(params[:id])
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(params[:meeting])
    @meeting.attendeePW = rand(36**20).to_s(36)
    @meeting.moderatorPW = rand(36**20).to_s(36)
    @meeting.user_id = session[:user_id]
    puts session[:user_id].inspect
    @meeting.name = @meeting.subject + Time.now.strftime('_%y%m%d')

    respond_to do |format|
      if @meeting.save

        format.html { redirect_to @meeting, notice: 'Meeting was successfully created.' }
        format.json { render json: @meeting, status: :created, location: @meeting }
      else
        format.html { render action: "new" }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /meetings/1
  # PUT /meetings/1.json
  def update
    @meeting = Meeting.find(params[:id])

    
    respond_to do |format|
      if @meeting.update_attributes(params[:meeting])
        format.html { redirect_to @meeting, notice: 'Meeting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    @meeting = Meeting.find(params[:id])
    @meeting.destroy

    respond_to do |format|
      format.html { redirect_to meetings_url }
      format.json { head :no_content }
    end
  end
end
