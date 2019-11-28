module Verticals
  class UpdateVertical < ApplicationService

    def initialize(vertical, params)
      @vertical = vertical
      @params = params
    end

    def call
      update_vertical!
      success(vertical)
    rescue ActiveRecord::RecordInvalid => e
      failure(ModelValidationError.new(e.record))
    end

    private

    attr_reader :params, :vertical

    def update_vertical!
      vertical.update!(valid_params)
    end

    def valid_params
      permitted_attributes(::Vertical)
    end

  end
end
