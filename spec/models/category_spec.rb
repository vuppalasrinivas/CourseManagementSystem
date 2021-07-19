require 'rails_helper'

RSpec.describe Category, type: :model do
  current_user = User.first_or_create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
  it "should have a name" do
    category = Category.new(name: '', parent_id: nil)
    expect(category).to_not be_valid
    category.name = "web development"
    expect(category).to be_valid
  end

  it "should have a sub category" do
    category1 = Category.create(name: 'web development', parent_id: nil)
    category2 = Category.create(name: 'web development', parent_id: category1.id)
    expect(category1.sub_categories.count).to be_eql(1)
  end

  it "should have a course" do
    category = Category.create(name: 'web development', parent_id: nil)
    course = Course.create(
        name: 'test course',
        description: 'A Valid description',
        user: current_user,
        short_description: 'test short description',
        price: 10,
        category_id: category.id
    )
    expect(category.courses.count).to eql(1)
  end


end
