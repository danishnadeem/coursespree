class FreeCode < ActiveRecord::Base
  attr_accessible :code, :user_id, :is_active
  belongs_to :user

  def self.search(search)
    if search
      where 'code LIKE ?', "%#{search}%"
    else
      scoped
    end
  end

end
