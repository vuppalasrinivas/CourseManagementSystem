require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  current_user = User.first_or_create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
  category = Category.create(name: 'web development', parent_id: nil)
  course = Course.first_or_create!(
      name: 'first course',
      description: 'A Valid description',
      user: current_user,
      short_description: 'test description',
      price: 10,
      category_id: category.id
  )

  it "should have a user_id" do
    enrollment = Enrollment.new(course_id: course.id)
    expect(enrollment).to_not be_valid
    enrollment.user_id = current_user.id
    expect(enrollment).to be_valid
  end

  it "should have a course_id" do
    enrollment = Enrollment.new(user_id: current_user.id)
    expect(enrollment).to_not be_valid
    enrollment.course_id = course.id
    expect(enrollment).to be_valid
  end

  it "should not have a duplicate enrollment" do
    enrollment1 = Enrollment.create(user_id: current_user.id, course_id: course.id )
    enrollment2 = Enrollment.create(user_id: current_user.id, course_id: course.id )
    expect(enrollment2).to_not be_valid
    expect(enrollment2.errors.messages[:course_id]).to eql(["has already been taken"])
    expect(enrollment2.errors.messages[:user_id]).to eql(["has already been taken"])
  end


end
