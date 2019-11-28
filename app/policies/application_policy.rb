class ApplicationPolicy

  attr_reader :record

  def initialize(authorization, record)
    @record = record
    @record = authorization
  end

  def permitted_attributes
    [
      :name
    ]
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    true
  end

  def destroy?
    true
  end

  class Scope

    attr_reader :scope, :authorization

    def initialize(authorization, scope)
      @scope = scope
      @authorization = authorization
    end

    def resolve
      scope.all
    end

  end

  private

  def authorize(object, action)
    policy = Pundit::PolicyFinder.new(authorization, object).policy!
    policy.new(authorization, object).send(action)
  end

end
