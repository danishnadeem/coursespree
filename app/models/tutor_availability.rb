class TutorAvailability < ActiveRecord::Base
  attr_accessible  :timetype, :length, :start_time, :tutor_id, :taken
  belongs_to :tutor
  has_one :meeting
  validates_presence_of :tutor_id
  
  #validates :start_time,
  #:date => { :after => Time.now, :before => Time.now + 1.year }

  
  def end_time
    start_time + 3600*length
  end

  def repeat
  end  
  
end
