class Transaction < ActiveRecord::Base
  attr_accessible :amount, :meeting_id, :tutor_id, :user_id
end
