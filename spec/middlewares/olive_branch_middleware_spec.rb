require 'rails_helper'

RSpec.describe OliveBranch::Middleware, type: :request do
  class TestController < ::ApplicationController

    def test
      egg = params.require(:snake_case).permit(:first_egg)
      render json: egg
    end

  end

  it "accepts and returns camelCase" do
    Rails.application.routes.draw { get "/test", to: 'test#test', params: { to: "test#test" } }
    get '/test', params: { snakeCase: { firstEgg: 1 } }, headers: { 'content-type': 'application/json' }
    expect_json(firstEgg: "1")
  end
end
