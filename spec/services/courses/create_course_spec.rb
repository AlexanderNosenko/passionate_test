require 'rails_helper'

RSpec.describe ::Courses::CreateCourse do
  subject { described_class.new(ActionController::Parameters.new(params)).call }
  let_it_be(:category) { create(:category) }
  let(:category_id) { category.id }

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

  describe '#call' do
    context 'notifications' do
      it_should_behave_like 'emailable', record_class: Course
    end

    context 'with valid params' do
      it 'creates course' do
        expect { subject }.to change { ::Course.count }.by(1)
      end

      it 'creates course with correct attributes' do
        service = subject

        expect(service.success?).to eq true
        result = service.result
        expect(result).to be_a ::Course

        params[:course].each do |key, value|
          expect(result[key]).to eq value
        end
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          course: {
            name: ''
          }
        }
      end

      it 'doesnt create course' do
        expect { subject }.to change { ::Course.count }.by(0)
      end

      it 'returns invalid record as error attribute' do
        service = subject

        expect(service.success?).to eq false
        expect(service.result).to eq nil
        expect(service.error).to be_a ModuleScaffold::Errors::ValidationError
      end
    end
  end
end
