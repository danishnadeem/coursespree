class TutorAvailability < ActiveRecord::Base
  attr_accessible :time_end, :time_start, :tutor_id, :weekly
end
