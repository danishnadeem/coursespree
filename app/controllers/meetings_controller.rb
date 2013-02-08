class MeetingsController < ApplicationController
  #protect_from_forgery :except => :ipn_notification
  before_filter :authticate, :except => :ipn_notification # to be updated with rails metal method
  def authticate
    unless User.find_by_id(session[:user_id])
      flash[:notice] = "Please log in."
      redirect_to :controller => 'admin', :action => 'login'
    end    
  end
  
  # GET /meetings
  # GET /meetings.json
  def index
    if current_user.usertype == "superadmin"
      @meetings = Meeting.all
	  
    elsif params[:type] == nil
      @meetings = Meeting.find(:all, :conditions => ["user_id = ? ", session[:user_id]] )#you are student
    elsif params[:type]=='pending' #meeting requested by the current user
      @meetings = Meeting.find(:all, :conditions=> ["accept =0 and status = 0 and (tutor_id = ? or user_id = ?)", session[:tutor_id], session[:user_id]])
    elsif params[:type]=='past'#meeting you attended in the past
      @meetings = Meeting.find(:all, :conditions=> ["(tutor_id = ? OR user_id = ? )and status >= ?", session[:tutor_id], session[:user_id], 3])
    elsif params[:type]=='attending' #meeting list that you will be attending(accepted, paid)
      @meetings = Meeting.find(:all, :conditions => ['(user_id = ? or tutor_id = ?) AND status = ? AND paid = ?', session[:user_id],session[:tutor_id], 1, true])
    elsif params[:type]=='unpaid' #meeting list that you will be attending(accepted, unpaid)
      @meetings = Meeting.find(:all, :conditions => ['(user_id = ? or tutor_id = ?) AND status = ? AND paid = ?', session[:user_id],session[:tutor_id], 1, false])
    else
      @meetings = Meeting.find(:all, :conditions => ['(user_id = ? or tutor_id = ?) AND status = ? AND paid = ?', session[:user_id],session[:tutor_id], 1, true])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @meetings }
    end
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
    begin
      @meeting = Meeting.find(params[:id])
      #more code here
    rescue ActiveRecord::RecordNotFound
      redirect_to :action=>"index", :type => "attending"
      return
    end
    
    xml_rsp = Typhoeus::Request.get(@meeting.runningurl).body
    
    if Nokogiri.XML(xml_rsp).xpath('//response/running')[0].content == "true"
      @running = true
    else
      @running = false
    end
    
    
    #if 
    #  @meeting.status = 0
    #  @meeting.save      
    #end
    
    if !params[:accept].nil? && params[:accept] == '1' && @meeting.tutor_id == session[:tutor_id]

      #only tutor for the meeting can accept the meeting
      @meeting.accept = 1
      @meeting.status = 1# status has further meanings, meeting started 2, meeting completed 2
      if @meeting.has_code
        @meeting.paid = true
      end
      @meeting.save
      redirect_to @meeting
      return
    elsif !params[:accept].nil? && params[:accept] == '-1' && @meeting.tutor_id == session[:tutor_id]
      @meeting.accept = -1
      @meeting.status = -1
      @meeting.save
      ta = @meeting.tutor_availability
      ta.taken = 0
      ta.save
      redirect_to @meeting
      return
    elsif !params[:started].nil? && params[:started] == '2' && (@meeting.tutor_id == session[:tutor_id] || @meeting.tutor_id == session[:tutor_id])
      @meeting.status = 2
      @meeting.save    
    elsif !params[:finish].nil? && (@meeting.user_id == session[:user_id] || @meeting.tutor_id == session[:tutor_id])
      @meeting.status = 3
      @meeting.save
    elsif !params[:accept].nil? && params[:accept] == '1' && @meeting.tutor_id != session[:tutor_id]
    end
    #puts params.inspect
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
    code = FreeCode.find_by_code(params[:code])

    @meeting = Meeting.new(params[:meeting])
    @meeting.attendeePW = rand(36**20).to_s(36)
    @meeting.moderatorPW = rand(36**20).to_s(36)
    @meeting.user_id = session[:user_id]
    unless code.blank?
      @meeting.has_code = true
    end
    #puts session[:user_id].inspect
    @meeting.name = Subject.find(@meeting.subject_id).title + Time.now.strftime('_%y%m%d%h%m')
    if @meeting.tutor.rate == 0
      @meeting.paid = true
    end
    @meeting.status = 0
    respond_to do |format|
      if @meeting.save
        ta = TutorAvailability.find(@meeting.tutor_availability_id)
        ta.taken = 1
        ta.save
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
  
  def payment
      
    if request.post? && !params[:mid].nil?
      #redirect_to(:back, notice: params[:oid])
        
      if !Meeting.find(params[:mid])
        redirect_to(:back, notice: "invalid order")
        return
      end# end if meeting info is valid
      meeting = Meeting.find(params[:mid])
      receiver1 = "seller_1343182998_biz@gmail.com"
      receiver2 = meeting.tutor.user.paypalEmail ? meeting.tutor.user.paypalEmail : meeting.tutor.user.email
   
      p "aaaaaaaaaaaaaaaaaaaaa", receiver2
      dddd
      meeting_price =meeting.tutor.rate*meeting.tutor_availability.length
      site_commission = meeting_price*0.2 # not used
      price =  "%.2f" % meeting_price
      ##commission = "%.2f" % site_commission #not used
      pay_request = PaypalAdaptive::Request.new
      #      serverbase = "http://198.101.226.133/"
      serverbase = "http://hidden-reef-7837.herokuapp.com/"
        
      data = {
        "returnUrl" => serverbase + "meetings/" + params[:mid].to_s,
        "requestEnvelope" => {"errorLanguage" => "en_US"},
        "currencyCode"=>"USD",
        "receiverList"=>{"receiver"=>[{"email"=>receiver1, "amount"=>price},{"email"=>receiver2, "amount"=> site_commission}]},
        "cancelUrl"=> serverbase + "meetings/" + params[:mid].to_s,
        "actionType"=>"PAY",
        "ipnNotificationUrl"=>serverbase + "meetings/ipn_notification"
      }
        
      pay_response = pay_request.pay(data)
        
      if pay_response.success?
        
        redirect_to pay_response.approve_paypal_payment_url
        #puts (pay_response['payKey'] + "test").inspect
        meeting.paykey = pay_response['payKey']
        meeting.paid =true
        #store paykey into the meeting data base
        meeting.save
      else
         
        flash[:notice] = pay_response.errors.first['message']
        
        redirect_to serverbase + "meetings/" + params[:mid].to_s
      end #end if pay response success
      return
    end# end if post payment with correct meeting
  end
  
  def joinmeeting
    meeting = Meeting.find(params[:id])
    if current_user.usertype == "tutor"
      response = Typhoeus::Request.get(meeting.createuri)
      rtcode =  Nokogiri.XML(response.body).xpath('//response/returncode')[0].content
      if rtcode == "SUCCESS"
        redirect_to meeting.tujoinuri
      else
        redirect_to :back, notice: "Failed when creating meeting, please try again" #doesn't seem possible
      end
      
    elsif current_user.usertype == "student"
      response = Typhoeus::Request.get(meeting.stjoinuri)
      rtcode =  Nokogiri.XML(response.body).xpath('//response/returncode')[0]
      
      if rtcode == "FAILED"
        redirect_to :back, notice: "Meeting not available, try again after the tutor start the meeting"
      else
        redirect_to meeting.stjoinuri
      end
    end
  end
  
  def ipn_notification
    # debug info #########################
    #puts "here goes inspect method"
    #puts params.inspect
    #puts ("status is : " + params["status"]).inspect
    
    if !params.nil? && params[:status] == "COMPLETED"
      #need to update code to verify paypal payment
      #to be tested
      m = Meeting.find_by_paykey(params[:pay_key])
      m.paid = true
      m.save
    end
    #send confirmation back to ipn
    #  uri = "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_notify-validate" + msg_body
    #  response = Net::HTTP.get(URI.parse(uri))    
  end  
  
  
end
#zia_95_1360165949_per