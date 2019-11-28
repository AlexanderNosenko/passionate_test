class ModelValidationError < ModuleScaffold::Errors::ValidationError

  code :unprocessable_entity
  http_code 422
  title 'Record is invalid'

end
