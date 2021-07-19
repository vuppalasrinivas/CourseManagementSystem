class Course < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length: {minimum: 5}
  validates :user_id, presence: true
  has_rich_text :description
  belongs_to :user
  has_many :lessons, dependent: :destroy
  has_many :enrollments
  belongs_to :category
  validate :creator_is_admin

  def creator_is_admin
    if !self.user
      errors.add(:base, "Course should have a user")
    elsif !self.user.has_role?(:admin)
      errors.add(:base, "User is not Admin")
    end
  end

  def to_s
    name
  end

  extend FriendlyId
  friendly_id :name, use: :slugged

  def bought(user)
    self.enrollments.where(user_id: [user.id], course_id: [self.id]).empty?
  end
end
