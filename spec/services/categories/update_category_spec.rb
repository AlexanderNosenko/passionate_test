require 'rails_helper'

RSpec.describe Categories::UpdateCategory do
  subject { described_class.new(category, ActionController::Parameters.new(params)).call }
  let_it_be(:category) { create(:category) }
  let_it_be(:vertical) { Vertical.first }

  let(:params) do
    {
      category: {
        vertical_id: vertical.id,
        name: Faker::ProgrammingLanguage.name,
        state: 'active'
      }
    }
  end

  describe '#call' do
    context 'with valid params' do
      it 'doesnt create new category' do
        expect { subject }.to change { Category.count }.by(0)
      end

      it 'updates category with correct attributes' do
        service = subject

        expect(service.success?).to eq true
        result = service.result
        expect(result).to be_a Category

        params[:category].each do |key, value|
          expect(result[key]).to eq value
        end
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          category: {
            name: ''
          }
        }
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
