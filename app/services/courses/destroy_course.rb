module Courses
  class DestroyCourse < ApplicationService

    def initialize(course)
      @course = course
    end

    def call
      course.destroy!
      success(course)
    rescue ActiveRecord::RecordNotDestroyed => e
      failure(e.record)
    end

    private

    attr_reader :params, :course

  end
end
