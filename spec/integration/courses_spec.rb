require 'swagger_helper'

RSpec.describe 'Courses', type: :request, rswag: true do
  let_it_be(:category) { create(:category) }
  let(:category_id) { category.id }
  let_it_be(:course) { create(:course) }
  let_it_be(:course_id) { course.id }

  let(:params) do
    {
      course: {
        name: Faker::Name.name,
        author: Faker::Name.name,
        category_id: category_id,
        state: 'active'
      }
    }
  end

  path '/api/courses' do
    get 'List all available courses in a given context' do
      tags 'Courses'
      produces 'application/json'

      let_it_be(:external_courses) do
        create_list(:course, 1)
      end

      response 200, :ok do
        schema(CourseDescriptor.schema(
          collection: true,
          relationships: [CategoryDescriptor]
        ))

        run_test! do
          expect_json_sizes('data', ::Course.count)
          expect_json('data.?.id', course.id.to_s)
        end
      end
    end

    post 'Create a course' do
      tags 'Courses'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: CourseDescriptor.new.request_attributes

      response 200, :ok do
        schema(CourseDescriptor.schema(
          relationships: [CategoryDescriptor]
        ))

        run_test! do
          expected_value = params[:course][:name]
          expect_json('data.attributes.name', expected_value)
        end
      end

      response 422, :unprocessable_entity do
        before { params[:course][:name] = '' }

        schema(ModuleScaffold::Descriptors::ValidationErrorDescriptor.schema)

        run_test!
      end
    end
  end

  path '/api/courses/{course_id}' do
    get 'Get details of a given course' do
      tags 'Courses'
      produces 'application/json'
      parameter name: :course_id, in: :path, type: :string

      response 200, :ok do
        schema(CourseDescriptor.schema(
          relationships: [CategoryDescriptor]
        ))

        run_test! do
          expect_json('data.id', course.id.to_s)
        end
      end

      response 404, :record_not_found do
        let(:vertical_id) { 'non_existent' }

        schema(ModuleScaffold::Descriptors::RecordNotFoundErrorDescriptor.schema)
      end
    end

    patch 'Update a given course' do
      tags 'Courses'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :course_id, in: :path, type: :string
      parameter name: :params, in: :body, schema: CourseDescriptor.new.request_attributes

      response 200, :ok do
        schema(CourseDescriptor.schema(
          relationships: [CategoryDescriptor]
        ))

        run_test! do
          expected_value = params[:course][:name]
          expect_json('data.attributes.name', expected_value)
        end
      end

      response 422, :unprocessable_entity do
        before { params[:course][:name] = '' }

        schema(ModuleScaffold::Descriptors::ValidationErrorDescriptor.schema)

        run_test! do
          expect_json('errors.0.source.pointer', '/data/attributes/name')
          expect_json('errors.0.detail', 'blank')
        end
      end
    end

    delete 'Destroy course' do
      tags 'Courses'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :course_id, in: :path, type: :string

      response 200, :ok do
        schema({})

        it 'destroys the course' do |example|
          expect do
            submit_request(example.metadata)
          end.to change { ::Course.count }.by(-1)
          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end
end
