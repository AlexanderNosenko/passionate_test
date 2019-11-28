class Vertical < ApplicationRecord

  has_many :categories, dependent: :destroy

  validates :name,
            presence: true,
            multi_model_uniqueness: { against: Category }

end
