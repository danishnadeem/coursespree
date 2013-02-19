class User < ActiveRecord::Base
  attr_accessible :university_id, :department_id, :major_id, :year, :bio, :active, :avatar, :ave_rating, :dob, :email, :fName, :fb_ID, :gender, :lName, :password, :paypalEmail, :seed, :username, :password_confirmation, :tutor
  
  has_many :free_codes
  has_many :meetings
  has_one :tutor
  has_one :superadmin
  belongs_to :university
  belongs_to :department
  has_many :transaction
  has_one :subadmin

  validates :username,  :presence => true 
  validates :password,  :presence => true
  validates :password_confirmation,  :presence => true
  validates :email,  :presence => true
  validates :fName,  :presence => true
  validates :lName,  :presence => true
  validates :university_id,  :presence => true
  validates :department_id,  :presence => true
  validates :bio,  :presence => true

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "60x60>"  },
    :url  => "/assets/useravatar/:id/:style/:basename.:extension",
    :path => ":rails_root/public/assets/useravatar/:id/:style/:basename.:extension",
    :default_url => "missing.png"
  validates_uniqueness_of :username
  validates_confirmation_of :password
  validate :password_non_blank

  def self.from_omniauth(auth)
    return if auth.provider != "facebook"
    where(:fb_uid => auth.uid).first_or_initialize.tap do |user|
      user.fb_uid =auth.uid
      user.fb_token = auth.credentials.token
      user.fb_token_expire =Time.at(auth.credentials.expires_at)
      
      if user.new_record?
        user.fName = auth.extra.raw_info.first_name
        user.lName = auth.extra.raw_info.last_name
        user.username = auth.extra.raw_info.username
        user.dob = Date.strptime(auth.extra.raw_info.birthday, '%m/%d/%Y')
        user.password = auth.extra.raw_info.username
        user.university_id = University.first.id
        user.active = 1
      end
      user.save!
      #user.provider = auth.provider
      #user.uid = auth.uid
      #user.name = auth.info.name
      #user.oauth_token = auth.credentials.token
      #user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      #user.save!
    end
  end

  
  def availabilities
    self.tutor.tutor_availabilities.count
  end
  
  def fullname
    fName.capitalize + " " + lName.capitalize
  end
  
  def locations_and_ids
    TutorLocation.find_all_by_university_id(university_id).map{|l| [l.name, l.id]}
  end
  
  def usertype
    tutor = Tutor.find_by_user_id(id)
    su = Superadmin.find_by_user_id(id)
    sub = Subadmin.find_by_user_id(id)
    #univ_admin = UnivsityAdmin.find_by_user_id(id)
    if tutor && tutor.approved == 1
      'tutor'
    elsif tutor && tutor.approved == 0
      'tem_tutor'
    elsif su
      'superadmin'
    elsif sub
      'subadmin'
    else
      'student'
    end
  end
  
  def self.authenticate(account, pswd)
    user = self.find_by_username(account)
    if user
      if user.pwd != encrypted_password(pswd, user.seed)
        user = nil
      end
    end
    user
  end

  def password
    @password
  end

  def password=(pswd)
    @password = pswd
    return if pswd.blank?
    create_new_seed
    self.pwd = User.encrypted_password(self.password, self.seed)
  end

  private

  def password_non_blank
    errors.add(:password, "Missing") if pwd.blank?  
  end

  def self.encrypted_password(pswd, seed)
    string_to_hash = pswd + "hoge" + seed
    Digest::SHA1.hexdigest(string_to_hash)
  end

  def create_new_seed
    self.seed = self.object_id.to_s + rand.to_s
  end
end
