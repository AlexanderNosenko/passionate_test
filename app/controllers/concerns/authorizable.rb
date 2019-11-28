module Authorizable
  extend ActiveSupport::Concern

  include Pundit

  def pundit_user
    nil
  end

  def authorize(*args)
    return super(*args) unless block_given?

    @_pundit_policy_authorized = true
    unless yield
      raise Pundit::NotAuthorizedError
    end
  end

  included do
    after_action :verify_authorized
    after_action :verify_policy_scoped, except: :create
  end
end
