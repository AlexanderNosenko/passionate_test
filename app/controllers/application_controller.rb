class ApplicationController < ActionController::API

  include Authorizable
  include ResponseHandler

end
