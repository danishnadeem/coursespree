class Tutor < ActiveRecord::Base
  attr_accessible :resume, :transcript, :univ_identifier, :university, :user_id, :approved
  has_attached_file :resume
  has_attached_file :transcript
  belongs_to :user
  
  validates_presence_of :transcript, :resume
  validates_uniqueness_of :user_id
end
