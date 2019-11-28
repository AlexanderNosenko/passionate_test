module Verticals
  class CreateVertical < ApplicationService

    include Emailable

    def initialize(params)
      @params = params
    end

    def call
      create_vertical!
      send_notification_email(vertical)
      success(vertical)
    rescue ActiveRecord::RecordInvalid => e
      failure(ModelValidationError.new(e.record))
    end

    private

    attr_reader :params, :vertical

    def create_vertical!
      @vertical = ::Vertical.create!(valid_params)
    end

    def valid_params
      permitted_attributes(::Vertical)
    end

  end
end
