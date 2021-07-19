module CoursesHelper
  def enrollment_button(course)
    if current_user
      if course.user == current_user
        link_to "you created this course view analytics", course_path(course)
      elsif course.enrollments.where(user: current_user).any?
        link_to "Enrolled!", course_path(course)
      elsif course.price > 0
        link_to number_to_currency(course.price), new_course_enrollment_path(course), class: 'btn btn-md btn-success'
      else
        link_to 'Free', new_course_enrollment_path(course), class: 'btn btn-md btn-success'
      end
    else
      link_to 'check price', course_path(course), class: 'btn btn-md btn-success'
    end
  end

  def categories
    Category.where(parent_id: nil)
  end
end
