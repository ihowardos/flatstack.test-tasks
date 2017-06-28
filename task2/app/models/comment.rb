class Comment < ApplicationRecord
  belongs_to :event

  def created_at_h
    created_at.strftime('%B %d, %Y at %I:%M%p')
  end

  def user_name
      User.find(user_id).user_name
  end
end
