class Subject < ActiveRecord::Base
  attr_accessible :description, :title
  has_many :subjects_tutors
  has_many :meetings

  
  validates_uniqueness_of :title
end
