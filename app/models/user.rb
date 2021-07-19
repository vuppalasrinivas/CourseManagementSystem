class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :courses
  has_many :enrollments

  after_create :assign_default_role

  def assign_default_role
    self.add_role(:student) if self.roles.blank?
  end

  def to_s
    email
  end

  def buy_course(course)
    self.enrollments.create(course: course, price: course.price)
  end
end
