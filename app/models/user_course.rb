class UserCourse < ActiveRecord::Base
  has_many :users, dependent: :destroy
  has_many :courses, dependent: :destroy

  validates :course_id, presence: true
  validates :user_id, presence: true
end
