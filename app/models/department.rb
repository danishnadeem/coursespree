class Department < ActiveRecord::Base
  attr_accessible :name, :note

  has_many :tutor_locations, :dependent => :destroy
  has_many :users
end
