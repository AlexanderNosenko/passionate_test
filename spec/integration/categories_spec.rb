require 'swagger_helper'

RSpec.describe 'Categories', type: :request, rswag: true do
  let_it_be(:category) { create(:category) }
  let(:category_id) { category.id }
  let_it_be(:vertical) { Vertical.first }

  let(:params) do
    {
      category: attributes_for(:category).merge(vertical_id: vertical.id)
    }
  end

  path '/api/categories' do
    get 'List all available categories in a given context' do
      tags 'Categories'
      produces 'application/json'

      let_it_be(:external_categories) do
        create_list(:category, 1)
      end

      response '200', 'ok' do
        schema(CategoryDescriptor.schema(
          collection: true,
          relationships: [VerticalDescriptor]
        ))

        run_test! do
          expect_json_sizes('data', ::Category.count)
          expect_json('data.?.id', category.id.to_s)
        end
      end
    end

    post 'Create a category' do
      tags 'Categories'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: CategoryDescriptor.new.request_attributes

      response '200', 'ok' do
        schema(CategoryDescriptor.schema(
          relationships: [VerticalDescriptor]
        ))

        run_test! do
          expected_value = params[:category][:name]
          expect_json('data.attributes.name', expected_value)
        end
      end

      response '422', 'unprocessable_entity' do
        before { params[:category][:name] = '' }

        schema(ModuleScaffold::Descriptors::ValidationErrorDescriptor.schema)
        run_test!
      end
    end
  end

  path '/api/categories/{category_id}' do
    get 'Get details of a given category' do
      tags 'Categories'
      produces 'application/json'
      parameter name: :category_id, in: :path, type: :string

      response '200', 'ok' do
        schema(CategoryDescriptor.schema(
          relationships: [VerticalDescriptor]
        ))

        run_test! do
          expect_json('data.id', category.id.to_s)
        end
      end

      response 404, :record_not_found do
        let(:category_id) { 'non_existent' }

        schema(ModuleScaffold::Descriptors::RecordNotFoundErrorDescriptor.schema)
      end
    end

    patch 'Update a given category' do
      tags 'Categories'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :category_id, in: :path, type: :string
      parameter name: :params, in: :body, schema: CategoryDescriptor.new.request_attributes

      response '200', 'ok' do
        schema(CategoryDescriptor.schema(
          relationships: [VerticalDescriptor]
        ))

        run_test! do
          expected_value = params[:category][:name]
          expect_json('data.attributes.name', expected_value)
        end
      end

      response '422', 'unprocessable_entity' do
        before { params[:category][:name] = '' }

        schema(ModuleScaffold::Descriptors::ValidationErrorDescriptor.schema)

        run_test! do
          expect_json('errors.0.source.pointer', '/data/attributes/name')
          expect_json('errors.0.detail', 'blank')
        end
      end
    end

    delete 'Destroy category' do
      tags 'Categories'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :category_id, in: :path, type: :string

      response '200', 'ok' do
        schema({})

        it 'destroys the category' do |example|
          expect do
            submit_request(example.metadata)
          end.to change { ::Category.count }.by(-1)
          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end
end
