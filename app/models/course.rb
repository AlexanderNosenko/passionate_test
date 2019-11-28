class Course < ApplicationRecord

  include Stateful

  belongs_to :category

  validates :name, presence: true

end
