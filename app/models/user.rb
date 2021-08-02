class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :stories
  ## username 必填，並為唯一值
  validates :username, presence: true, uniqueness: true
  has_one_attached :avatar
end
