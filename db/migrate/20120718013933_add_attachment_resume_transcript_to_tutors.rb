class AddAttachmentResumeTranscriptToTutors < ActiveRecord::Migration
  def self.up
    change_table :tutors do |t|
      t.has_attached_file :resume
      t.has_attached_file :transcript
    end
  end

  def self.down
    drop_attached_file :tutors, :resume
    drop_attached_file :tutors, :transcript
  end
end
