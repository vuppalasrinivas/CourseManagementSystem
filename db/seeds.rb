# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create(email: 'admin@test.com', password: '123456', password_confirmation: '123456' )
user1.add_role(:admin)

user2 = User.create(email: 'student@test.com', password: '123456', password_confirmation: '123456' )
user2.add_role(:student)

Category.create(name: 'Web Development', parent_id: nil)
Category.create(name: 'Data Science', parent_id: nil)
Category.create(name: 'Mobile Development', parent_id: nil)
Category.create(name: 'Programming Languages', parent_id: nil)
Category.create(name: 'Software Testing', parent_id: nil)

Category.create(name: 'Javascript', parent_id: 1)
Category.create(name: 'React', parent_id: 1)

Category.create(name: 'Python', parent_id: 2)
Category.create(name: 'Machine Learning', parent_id: 2)

Category.create(name: 'Google Flutter', parent_id: 3)
Category.create(name: 'Android Development', parent_id: 3)

Category.create(name: 'Ruby', parent_id: 4)
Category.create(name: 'Python', parent_id: 4)

Category.create(name: 'Selenium Webdriver', parent_id: 5)
Category.create(name: 'Java', parent_id: 5)


10.times do
  course = Course.create(name: Faker::ProgrammingLanguage.name,
                description: Faker::Quote.famous_last_words,
                user_id: User.first.id,
                category_id: rand(6..15), price: rand(100..200)
  )

  2.times do
    course.lessons.create(title: Faker::Quote.robin, content: Faker::Quote.famous_last_words)
  end
end


user2.enrollments.create(course_id: Course.first.id, price: Course.first.price)
user2.enrollments.create(course_id: Course.second.id, price: Course.second.price)
user2.enrollments.create(course_id: Course.third.id, price: 100)
user2.enrollments.create(course_id: Course.fourth.id, price: 50)
