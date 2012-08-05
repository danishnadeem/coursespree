class TutorAvailability < ActiveRecord::Base
  attr_accessible :dayofweek, :length, :start_time, :tutor_id, :weeksche_mark
  belongs_to :tutor
  has_one :meeting
  
  def end_time
    start_time + 3600*length
  end
  
  
end
