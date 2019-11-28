class RecordNotFoundError < ApplicationError

  code :record_not_found
  http_code 404
  title 'Record has not been found'

end
