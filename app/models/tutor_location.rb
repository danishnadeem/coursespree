class TutorLocation < ActiveRecord::Base
  attr_accessible :name, :university_id
  
  belongs_to :university
  has_many :meetings
end
