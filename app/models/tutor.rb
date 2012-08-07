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
  #validates_presence_of :transcript, :resume
  validates_uniqueness_of :user_id
  
  def open_virtual_slots
    TutorAvailability.find(:all, :conditions => ["tutor_id = ? AND taken = ? AND timetype = ? AND start_time >= ?", id, 0, 0 ,Time.now], :limit => 5, :order => "start_time")
  end
  def open_faced_slots
    TutorAvailability.find(:all, :conditions => ["tutor_id = ? AND taken = ? AND timetype = ? AND start_time >= ?", id, 0, 1 ,Time.now], :limit => 5, :order => "start_time")
  end
    
  
  def open_durations
  end
  
  def subjects
    subjects_tutors.all.map{|st| st.subject}
  end
  
  def subjs_and_ids
    subjects.map{|s| [s.title,s.id]}.push(["Other",7])
  end
  
  def available_subjects
    Subject.all - subjects
  end
  
end
