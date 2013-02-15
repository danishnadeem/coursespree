class Transaction < ActiveRecord::Base
  attr_accessible :amount, :meeting_id, :tutor_id, :user_id, :pay_key

  belongs_to :meeting
  belongs_to :tutor
  belongs_to :user
end
