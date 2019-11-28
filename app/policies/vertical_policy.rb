class VerticalPolicy < ApplicationPolicy

  def permitted_attributes
    [
      :name
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
