class SubjectsTutor < ActiveRecord::Base
  attr_accessible :subject_id, :tutor_id
  belongs_to :subject
  belongs_to :tutor
end
