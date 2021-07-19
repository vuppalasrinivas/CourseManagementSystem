module CategoriesHelper
  def active_category(id)
    id == params[:category].to_i ? "active" : ""
  end
end
