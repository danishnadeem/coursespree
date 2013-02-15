class FreeCode < ActiveRecord::Base
  attr_accessible :code, :user_id, :is_active
  belongs_to :user
end
