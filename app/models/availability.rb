class Availability < ActiveRecord::Base
  attr_accessible :timetype, :taken, :tutor_id, :start_time, :length
  belongs_to :tutor
  #  has_one :meeting
  validates_presence_of :tutor_id

  def end_time
    start_time + 3600*length
  end

  def repeat
  end
end
