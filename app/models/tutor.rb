class Tutor < ActiveRecord::Base
  attr_accessible :rate, :resume, :transcript, :univ_identifier, :university, :user_id, :approved
  has_attached_file :resume,
                    :url  => "/assets/resume/:id/:basename.:extension",
                    :path => ":rails_root/public/assets/resume/:id/:basename.:extension"
  has_attached_file :transcript,
                    :url  => "/assets/resume/:id/:basename.:extension",
                    :path => ":rails_root/public/assets/resume/:id/:basename.:extension"  
  belongs_to :user
  has_many :meetings
  has_many :subjects_tutors
  has_many :tutor_availabilities
  validates_presence_of :transcript, :resume
  validates_uniqueness_of :user_id
end
