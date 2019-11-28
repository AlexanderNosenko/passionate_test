class VerticalDescriptor < ModuleScaffold::Descriptors::ModelDescriptor

  def type
    'vertical'
  end

  def response_attributes
    {
      name: { type: :string, 'x-nullable': true }
    }
  end

  def request_attributes
    {
      type: :object,
      properties: {
        vertical: {
          type: :object,
          properties: {
            name: { type: :string, 'x-nullable': true }
          }
        }
      },
      required: ['vertical']
    }
  end

end
