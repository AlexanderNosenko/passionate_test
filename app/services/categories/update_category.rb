module Categories
  class UpdateCategory < ApplicationService

    def initialize(category, params)
      @category = category
      @params = params
    end

    def call
      update_category!
      success(category)
    rescue ActiveRecord::RecordInvalid => e
      failure(ModelValidationError.new(e.record))
    end

    private

    attr_reader :params, :category

    def update_category!
      category.update!(valid_params)
    end

    def valid_params
      permitted_attributes(::Category)
    end

  end
end
