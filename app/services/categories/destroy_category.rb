module Categories
  class DestroyCategory < ApplicationService

    def initialize(category)
      @category = category
    end

    def call
      category.destroy!
      success(category)
    rescue ActiveRecord::RecordNotDestroyed => e
      failure(e.record)
    end

    private

    attr_reader :params, :category

  end
end
