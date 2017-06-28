class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :events

  validates :name, :surname, presence: true, length: { in: 2..16 }

  def user_name
    "#{name} #{surname}"
  end
end
