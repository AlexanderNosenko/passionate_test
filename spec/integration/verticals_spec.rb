require 'swagger_helper'

RSpec.describe 'Verticals', type: :request, rswag: true do
  let(:vertical) { ::Vertical.last }
  let(:vertical_id) { vertical.id }

  let(:params) do
    {
      vertical: {
        name: Faker::Name.first_name
      }
    }
  end

  path '/api/verticals' do
    get 'List all available verticals in a given context' do
      tags 'Verticals'
      produces 'application/json'

      let_it_be(:external_verticals) do
        create_list(:vertical, 1)
      end

      response 200, :ok do
        schema(VerticalDescriptor.schema(collection: true))

        run_test! do
          expect_json_sizes('data', Vertical.count)
        end
      end
    end

    post 'Create a vertical' do
      tags 'Verticals'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: VerticalDescriptor.new.request_attributes

      response 200, :ok do
        schema(VerticalDescriptor.schema)

        run_test! do
          expected_value = params[:vertical][:name]
          expect_json('data.attributes.name', expected_value)
        end
      end

      response 422, :unprocessable_entity do
        let(:params) do
          {
            vertical: {
              name: ''
            }
          }
        end

        schema(ModuleScaffold::Descriptors::ValidationErrorDescriptor.schema)
        run_test!
      end
    end
  end

  path '/api/verticals/{vertical_id}' do
    get 'Get details of a given vertical' do
      tags 'Verticals'
      produces 'application/json'
      parameter name: :vertical_id, in: :path, type: :string

      response 200, :ok do
        schema(VerticalDescriptor.schema)

        run_test! do
          expect_json('data.id', vertical.id.to_s)
        end
      end

      response 404, :record_not_found do
        let(:vertical_id) { 'non_existent' }

        schema(ModuleScaffold::Descriptors::RecordNotFoundErrorDescriptor.schema)
      end
    end

    patch 'Update a given vertical' do
      tags 'Verticals'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :vertical_id, in: :path, type: :string
      parameter name: :params, in: :body, schema: VerticalDescriptor.new.request_attributes

      response 200, :ok do
        schema(VerticalDescriptor.schema)

        run_test! do
          expected_value = params[:vertical][:name]
          expect_json('data.attributes.name', expected_value)
        end
      end

      response 422, :unprocessable_entity do
        let(:params) do
          {
            vertical: {
              name: ''
            }
          }
        end

        schema(ModuleScaffold::Descriptors::ValidationErrorDescriptor.schema)

        run_test! do
          expect_json('errors.0.source.pointer', '/data/attributes/name')
          expect_json('errors.0.detail', 'blank')
        end
      end
    end

    delete 'Destroy vertical' do
      tags 'Verticals'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :vertical_id, in: :path, type: :string

      response 200, :ok do
        schema({})

        it 'destroys the vertical' do |example|
          expect do
            submit_request(example.metadata)
          end.to change { ::Vertical.count }.by(-1)
          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end
end
