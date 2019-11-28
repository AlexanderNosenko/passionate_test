module Courses
  class CreateCourse < ApplicationService

    def initialize(params)
      @params = params
    end

    def call
      create_course!
      success(course)
    rescue ActiveRecord::RecordInvalid => e
      failure(ModelValidationError.new(e.record))
    end

    private

    attr_reader :params, :course

    def create_course!
      @course = ::Course.create!(valid_params)
    end

    def valid_params
      permitted_attributes(::Course)
    end

  end
end
