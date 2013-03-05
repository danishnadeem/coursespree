class Department < ActiveRecord::Base
  attr_accessible :name, :note, :university_id

#  has_many :tutor_locations
  has_many :users
  belongs_to :university
  validates_presence_of :university_id
end
