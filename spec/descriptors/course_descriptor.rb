class CourseDescriptor < ModuleScaffold::Descriptors::ModelDescriptor

  def type
    'course'
  end

  def response_attributes
    {
      name: { type: :string },
      author: { type: :string, 'x-nullable': true },
      state: { type: :string }
    }
  end

  def request_attributes
    {
      type: :object,
      properties: {
        course: {
          type: :object,
          properties: {
            category_id: { type: :string },
            name: { type: :string },
            author: { type: :string, 'x-nullable': true },
            state: { type: :string, 'x-nullable': true }
          }
        }
      },
      required: ['course']
    }
  end

end
