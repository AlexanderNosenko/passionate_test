module Stateful
  extend ActiveSupport::Concern

  included do
    enum status: {
      inactive: 0,
      active: 1
    }

    validates :state, presence: true
  end
end
