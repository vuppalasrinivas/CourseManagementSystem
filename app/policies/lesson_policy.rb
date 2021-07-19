class LessonPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end

    def show?
      @user.has_role? :admin
    end
    def edit?
      true
      # @user.has_role? :admin
    end

    def update?
      @user.has_role? :admin
    end

    def new?
      @user.has_role? :admin
    end

    def create?
      @user.has_role? :admin
    end

    def destroy?
      @user.has_role? :admin
    end


  end
end
