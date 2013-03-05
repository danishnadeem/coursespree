class University < ActiveRecord::Base
  attr_accessible :name, :note
  
  has_many :tutor_locations, :dependent => :destroy
  has_many :users
  has_many :departments
end
