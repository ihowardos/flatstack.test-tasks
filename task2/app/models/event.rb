class Event < ApplicationRecord
  belongs_to :user

  validates :title, :description, :date, presence: true
  validates :title, length: { in: 4..32 }
  validates :description, length: { in: 16..256 }
end
