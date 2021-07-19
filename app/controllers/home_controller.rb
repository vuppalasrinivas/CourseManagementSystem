class HomeController < ApplicationController
  def index
    @enrolled_courses_ids = current_user.enrollments.pluck(:course_id)
    @enrolled_courses = Course.where(id: @enrolled_courses_ids)
    @recent_courses = Course.order(created_at: :desc).limit(10)
  end
end
