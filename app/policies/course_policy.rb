class CoursePolicy < ApplicationPolicy

  def permitted_attributes
    [
      :name,
      :author,
      :category_id,
      :state
    ]
  end

  def index?
    true
  end

  def create?
    true
  end

  def show?
    true
  end

  def update?
    true
  end

  def destroy?
    update?
  end

  class Scope < Scope

    def resolve
      scope.all
    end

  end

end
