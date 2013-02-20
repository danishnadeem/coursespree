class TutorLocation < ActiveRecord::Base
  attr_accessible :name, :university_id
  
  belongs_to :university
#  belongs_to :department

  has_many :meetings
end
