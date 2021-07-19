require 'rails_helper'

RSpec.describe Lesson, type: :model do
  current_user = User.first_or_create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
  current_user.add_role(:admin)
  category = Category.first_or_create!(name: 'Web Development', parent_id: nil)
  course = Course.first_or_create!(
      name: 'web development',
      description: 'A Valid description',
      user: current_user,
      short_description: 'description',
      price: 10,
      category_id: category.id
  )

  it 'has a title' do
    lesson = Lesson.new(title: '', content: 'lesson content', course_id: course.id)
    expect(lesson).to_not be_valid
    lesson.title = 'first lesson'
    expect(lesson).to be_valid
  end

  it 'has a content' do
    lesson = Lesson.new(title: 'first lesson', content: '', course_id: course.id)
    expect(lesson).to_not be_valid
    lesson.content = 'example content'
    expect(lesson).to be_valid
  end

  it 'should belongs to course' do
    lesson = Lesson.new(title: 'first lesson', content: 'example content')
    expect(lesson).to_not be_valid
    lesson.course_id = course.id
    expect(lesson).to be_valid
  end

  it 'should return lesson name if to_s method is called' do
    lesson = Lesson.new(title: 'first lesson', content: 'example content', course_id: course.id)
    expect(lesson.to_s).to eq('first lesson')
  end

  it 'should increase lessons count by 1' do
    expect(course.lessons.count).to eq 0
    course.lessons.create(title: 'lesson title', content: 'lesson content', course_id: course.id)
    expect(course.lessons.count).to eq 1
  end
end
