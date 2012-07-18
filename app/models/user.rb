class User < ActiveRecord::Base
  attr_accessible :active, :avatar, :ave_rating, :dob, :email, :fName, :fb_ID, :gender, :lName, :password, :paypalEmail, :seed, :username, :password_confirmation, :tutor
  
  has_many :meetings
  has_one :tutor
  has_one :superadmin
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates_uniqueness_of :username
  validates_confirmation_of :password
  validate :password_non_blank
  
  def usertype
    tutor = Tutor.find_by_user_id(id)
    su = Superadmin.find_by_user_id(id)
    if tutor && tutor.approved == 1
      'tutor'
    elsif tutor && tutor.approved == 0
      'tem_tutor'
    elsif su
      'superadmin'
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
