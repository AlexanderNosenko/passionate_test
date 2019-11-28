module Categories
  class CreateCategory < ApplicationService

    def initialize(params)
      @params = params
    end

    def call
      create_category!
      success(category)
    rescue ActiveRecord::RecordInvalid => e
      failure(ModelValidationError.new(e.record))
    end

    private

    attr_reader :params, :category

    def create_category!
      @category = ::Category.create!(valid_params)
    end

    def valid_params
      permitted_attributes(::Category)
    end

  end
end
