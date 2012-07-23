class Subject < ActiveRecord::Base
  attr_accessible :description, :title
  has_many :subjects_tutors

  
  validates_uniqueness_of :title
end
