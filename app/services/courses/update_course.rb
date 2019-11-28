module Courses
  class UpdateCourse < ApplicationService

    def initialize(course, params)
      @course = course
      @params = params
    end

    def call
      update_course!
      success(course)
    rescue ActiveRecord::RecordInvalid => e
      failure(ModelValidationError.new(e.record))
    end

    private

    attr_reader :params, :course

    def update_course!
      course.update!(valid_params)
    end

    def valid_params
      permitted_attributes(::Course)
    end

  end
end
