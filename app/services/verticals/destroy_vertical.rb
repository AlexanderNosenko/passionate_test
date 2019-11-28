module Verticals
  class DestroyVertical < ApplicationService

    def initialize(vertical)
      @vertical = vertical
    end

    def call
      vertical.destroy!
      success(vertical)
    rescue ActiveRecord::RecordNotDestroyed => e
      failure(e.record)
    end

    private

    attr_reader :params, :vertical

  end
end
