class CategoryDescriptor < ModuleScaffold::Descriptors::ModelDescriptor

  def type
    'category'
  end

  def response_attributes
    {
      name: { type: :string, 'x-nullable': true },
      state: { type: :string, 'x-nullable': true }
    }
  end

  def request_attributes
    {
      type: :object,
      properties: {
        category: {
          type: :object,
          properties: {
            name: { type: :string },
            vertical_id: { type: :string },
            state: { type: :string, 'x-nullable': true }
          }
        }
      },
      required: ['category']
    }
  end

end
