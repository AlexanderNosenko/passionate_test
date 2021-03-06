class Category < ApplicationRecord

  include Stateful

  belongs_to :vertical
  has_many :courses, dependent: :destroy

  validates :name,
            presence: true,
            multi_model_uniqueness: { against: Vertical }

end
