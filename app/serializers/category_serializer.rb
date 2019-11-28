class CategorySerializer < ApplicationSerializer

  attributes :name, :state

  belongs_to :vertical

end
