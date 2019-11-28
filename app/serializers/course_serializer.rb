class CourseSerializer < ApplicationSerializer

  attributes :name,
                            :author,
                            :state

  belongs_to :category

end
