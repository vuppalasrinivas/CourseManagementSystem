
require 'rails_helper'

RSpec.describe Course, type: :model do
  current_user = User.first_or_create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
  current_user.add_role(:admin)
  category = Category.first_or_create!(name: 'Web Development', parent_id: nil)

  it 'has a name' do
    course = Course.new(
        name: '',
        description: 'A Valid description',
        user: current_user,
        short_description: '',
        price: 10,
        category_id: category.id
    )
    expect(course).to_not be_valid

    course.name = 'Has a name'
    expect(course).to be_valid
  end

  it 'has a description' do
    course = Course.new(
        name: 'A Valid Name',
        description: '',
        user: current_user,
        short_description: '',
        price: 10,
        category_id: category.id
    )
    expect(course).to_not be_valid

    course.description = 'Has a description'
    expect(course).to be_valid
  end

  it 'has a User' do
    course = Course.new(
        name: 'A Valid Name',
        description: 'Has a description',
        short_description: '',
        price: 10,
        category_id: category.id
    )
    expect(course).to_not be_valid

    course.user = current_user
    expect(course).to be_valid
  end

  it 'has a Category' do
    course = Course.new(
        name: 'A Valid Name',
        description: 'Has a description',
        short_description: '',
        price: 10,
        user: current_user
    )
    expect(course).to_not be_valid

    course.category_id = category.id
    expect(course).to be_valid
  end

  it 'has a one Lesson' do
    course = Course.create(
        name: 'A Valid Name',
        description: 'Has a description',
        short_description: '',
        price: 10,
        user: current_user,
        category_id: category.id
    )

    expect(course.lessons.count).to eq 0
    course.lessons.create(title: 'lesson title', content: 'lesson content')
    expect(course.lessons.count).to eq 1
  end

  it 'Should not create Course for student role' do
    student = User.create!(email: 'studnet@example.com', password: 'password', password_confirmation: 'password')
    student.add_role(:student)
    course = Course.new(
        name: 'A Valid Name with student role',
        description: 'Has a description',
        short_description: '',
        price: 10,
        user: student,
        category_id: category.id
    )
    course.save
    expect(course).to_not be_valid
    student.add_role(:admin)
    expect(course).to be_valid

  end
end