module Stateful
  extend ActiveSupport::Concern

  included do
    enum state: {
      inactive: 0,
      active: 1
    }

    validates :state, presence: true
  end
end
