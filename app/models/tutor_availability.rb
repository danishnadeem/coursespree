class TutorAvailability < ActiveRecord::Base
  attr_accessible  :timetype, :length, :start_time, :tutor_id, :taken
  belongs_to :tutor
  has_one :meeting
  
  
  validate :start_time_taken
  validate :end_time_taken
  validates :start_time,
  :date => { :after => Time.now, :before => Time.now + 1.year }
  
  def end_time
    start_time + 3600*length
  end

  def repeat
  end
  
  def duration
    start_time.strftime("%H:%M") + "~" + end_time.strftime("%H:%M")
  end
  
  def start_time_taken
  end
  
  def end_time_taken
  end
  
  
end
