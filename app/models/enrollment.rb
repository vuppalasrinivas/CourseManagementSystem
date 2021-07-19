class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :user
  validates :course_id, :user_id, presence: true
  validates :course_id, :uniqueness => { :scope => :user_id }
  validates :user_id, :uniqueness => { :scope => :course_id }
end
