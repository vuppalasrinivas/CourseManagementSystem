# class CoursePolicy < ApplicationPolicy
#   class Scope < Scope
#     def resolve
#       scope.all
#     end
#
#     def edit?
#       @user.has_role? :admin
#     end
#
#     def update?
#       @user.has_role? :admin
#     end
#
#     def new?
#       true
#       # @user.has_role? :admin
#     end
#
#     def create?
#       @user.has_role? :admin
#     end
#
#     def destroy?
#       @user.has_role? :admin
#     end
#   end
# end


class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user.has_role?(:admin)
  end

  def new?
    user.has_role?(:admin)
  end

  def edit?
    @user.has_role? :admin
  end

  def update?
    @user.has_role? :admin
  end

  def create?
    @user.has_role? :admin
  end

  def destroy?
    @user.has_role? :admin
  end
end
