class Department < ActiveRecord::Base
  attr_accessible :name, :note, :university_id

  has_many :tutor_locations, :dependent => :destroy
  has_many :users
  belongs_to :university
end
