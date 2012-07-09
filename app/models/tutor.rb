class Tutor < ActiveRecord::Base
  attr_accessible :resume, :transcript, :univ_identifier, :university, :user_id
  
  belongs_to :user
  
  validates_presence_of :transcript, :resume
end
