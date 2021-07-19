module ApplicationHelper
  include Pagy::Frontend

  def is_admin?
    current_user && current_user.has_role?(:admin)
  end

end
