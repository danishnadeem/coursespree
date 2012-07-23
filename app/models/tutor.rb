class Tutor < ActiveRecord::Base
  attr_accessible :rate, :resume, :transcript, :univ_identifier, :university, :user_id, :approved
  has_attached_file :resume
  has_attached_file :transcript
  belongs_to :user
  has_many :meetings
  has_many :subjects_tutors
  has_many :tutor_availabilities
  validates_presence_of :transcript, :resume
  validates_uniqueness_of :user_id
end
